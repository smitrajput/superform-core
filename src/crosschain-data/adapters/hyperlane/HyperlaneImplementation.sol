// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import { IAmbImplementationV2 as IAmbImplementation } from "src/interfaces/IAmbImplementationV2.sol";
import { IBaseStateRegistry } from "src/interfaces/IBaseStateRegistry.sol";
import { ISuperRBAC } from "src/interfaces/ISuperRBAC.sol";
import { ISuperRegistry } from "src/interfaces/ISuperRegistry.sol";
import { DataLib } from "src/libraries/DataLib.sol";
import { ProofLib } from "src/libraries/ProofLib.sol";
import { Error } from "src/libraries/Error.sol";
import { AMBMessage } from "src/types/DataTypes.sol";
import { IMailbox } from "src/vendor/hyperlane/IMailbox.sol";
import { IMessageRecipient } from "src/vendor/hyperlane/IMessageRecipient.sol";
import { IInterchainGasPaymaster } from "src/vendor/hyperlane/IInterchainGasPaymaster.sol";
import { StandardHookMetadata } from "src/vendor/hyperlane/StandardHookMetadata.sol";

/// @title HyperlaneImplementation
/// @dev Allows state registries to use Hyperlane v3 for crosschain communication
/// @author Zeropoint Labs
contract HyperlaneImplementation is IAmbImplementation, IMessageRecipient {
    using DataLib for uint256;
    using ProofLib for AMBMessage;

    //////////////////////////////////////////////////////////////
    //                         CONSTANTS                        //
    //////////////////////////////////////////////////////////////

    ISuperRegistry public immutable superRegistry;

    //////////////////////////////////////////////////////////////
    //                     STATE VARIABLES                      //
    //////////////////////////////////////////////////////////////

    IMailbox public mailbox;
    IInterchainGasPaymaster public igp;

    mapping(uint64 => uint32) public ambChainId;
    mapping(uint32 => uint64) public superChainId;
    mapping(uint32 => address) public authorizedImpl;
    mapping(bytes32 => bool) public processedMessages;
    mapping(bytes32 => bool) public ambProtect;

    //////////////////////////////////////////////////////////////
    //                          EVENTS                          //
    //////////////////////////////////////////////////////////////

    event MailboxAdded(address indexed _newMailbox);
    event GasPayMasterAdded(address indexed _igp);

    //////////////////////////////////////////////////////////////
    //                       MODIFIERS                          //
    //////////////////////////////////////////////////////////////

    modifier onlyProtocolAdmin() {
        if (!ISuperRBAC(superRegistry.getAddress(keccak256("SUPER_RBAC"))).hasProtocolAdminRole(msg.sender)) {
            revert Error.NOT_PROTOCOL_ADMIN();
        }
        _;
    }

    modifier onlyValidStateRegistry() {
        if (!superRegistry.isValidStateRegistry(msg.sender)) {
            revert Error.NOT_STATE_REGISTRY();
        }
        _;
    }

    modifier onlyMailbox() {
        if (msg.sender != address(mailbox)) {
            revert Error.CALLER_NOT_MAILBOX();
        }
        _;
    }

    //////////////////////////////////////////////////////////////
    //                      CONSTRUCTOR                         //
    //////////////////////////////////////////////////////////////

    constructor(ISuperRegistry superRegistry_) {
        superRegistry = superRegistry_;
    }

    //////////////////////////////////////////////////////////////
    //                         CONFIG                            //
    //////////////////////////////////////////////////////////////

    /// @dev allows protocol admin to configure hyperlane mailbox and gas paymaster
    /// @param mailbox_ is the address of hyperlane mailbox
    /// @param igp_ is the address of hyperlane gas paymaster
    function setHyperlaneConfig(IMailbox mailbox_, IInterchainGasPaymaster igp_) external onlyProtocolAdmin {
        if (address(mailbox_) == address(0) || address(igp_) == address(0)) revert Error.ZERO_ADDRESS();
        mailbox = mailbox_;
        igp = igp_;

        emit MailboxAdded(address(mailbox_));
        emit GasPayMasterAdded(address(igp_));
    }

    //////////////////////////////////////////////////////////////
    //              EXTERNAL VIEW FUNCTIONS                     //
    //////////////////////////////////////////////////////////////

    /// @inheritdoc IAmbImplementation
    function estimateFees(
        uint64 dstChainId_,
        bytes memory message_,
        bytes memory extraData_
    )
        external
        view
        override
        returns (uint256 fees)
    {
        uint32 domain = ambChainId[dstChainId_];

        if (domain == 0) {
            revert Error.INVALID_CHAIN_ID();
        }

        fees = mailbox.quoteDispatch(
            domain, _castAddr(authorizedImpl[domain]), message_, _generateHookMetadata(extraData_, msg.sender)
        );
    }

    /// @inheritdoc IAmbImplementation
    function generateExtraData(uint256 gasLimit) external pure override returns (bytes memory extraData) {
        /// @notice encoded dst gas limit
        extraData = abi.encode(gasLimit);
    }

    //////////////////////////////////////////////////////////////
    //              EXTERNAL WRITE FUNCTIONS                    //
    //////////////////////////////////////////////////////////////

    /// @inheritdoc IAmbImplementation
    function dispatchPayload(
        address srcSender_,
        uint64 dstChainId_,
        bytes memory message_,
        bytes memory extraData_
    )
        external
        payable
        virtual
        override
        onlyValidStateRegistry
    {
        uint32 domain = ambChainId[dstChainId_];

        if (domain == 0) {
            revert Error.INVALID_CHAIN_ID();
        }

        address authImpl = authorizedImpl[domain];
        if (authImpl == address(0)) revert Error.ZERO_ADDRESS();

        mailbox.dispatch{ value: msg.value }(
            domain, _castAddr(authImpl), message_, _generateHookMetadata(extraData_, srcSender_)
        );
    }

    /// @inheritdoc IAmbImplementation
    function retryPayload(bytes memory data_) external payable override {
        (bytes32 messageId, uint32 destinationDomain, uint256 gasAmount) = abi.decode(data_, (bytes32, uint32, uint256));
        uint256 fees = igp.quoteGasPayment(destinationDomain, gasAmount);

        if (msg.value < fees) {
            revert Error.INVALID_RETRY_FEE();
        }

        /// refunds any excess msg.value to msg.sender
        igp.payForGas{ value: msg.value }(messageId, destinationDomain, gasAmount, msg.sender);
    }

    /// @dev allows protocol admin to add new chain ids in future
    /// @param superChainId_ is the identifier of the chain within superform protocol
    /// @param ambChainId_ is the identifier of the chain given by the AMB
    /// NOTE: cannot be defined in an interface as types vary for each message bridge (amb)
    function setChainId(uint64 superChainId_, uint32 ambChainId_) external onlyProtocolAdmin {
        if (superChainId_ == 0 || ambChainId_ == 0) {
            revert Error.INVALID_CHAIN_ID();
        }

        // @dev  reset old mappings
        uint64 oldSuperChainId = superChainId[ambChainId_];
        uint32 oldAmbChainId = ambChainId[superChainId_];

        if (oldSuperChainId != 0) {
            delete ambChainId[oldSuperChainId];
        }

        if (oldAmbChainId != 0) {
            delete superChainId[oldAmbChainId];
        }

        ambChainId[superChainId_] = ambChainId_;
        superChainId[ambChainId_] = superChainId_;

        emit ChainAdded(superChainId_);
    }

    /// @dev allows protocol admin to set receiver implementation on a new chain id
    /// @param domain_ is the identifier of the destination chain within hyperlane
    /// @param authorizedImpl_ is the implementation of the hyperlane message bridge on the specified destination
    /// NOTE: cannot be defined in an interface as types vary for each message bridge (amb)
    function setReceiver(uint32 domain_, address authorizedImpl_) external onlyProtocolAdmin {
        if (domain_ == 0) {
            revert Error.INVALID_CHAIN_ID();
        }

        if (authorizedImpl_ == address(0)) {
            revert Error.ZERO_ADDRESS();
        }

        authorizedImpl[domain_] = authorizedImpl_;

        emit AuthorizedImplAdded(domain_, authorizedImpl_);
    }

    /// @inheritdoc IMessageRecipient
    function handle(uint32 origin_, bytes32 sender_, bytes calldata body_) external payable override onlyMailbox {
        /// @dev 1. validate caller
        /// @dev 2. validate src chain sender
        /// @dev 3. validate message uniqueness

        if (sender_ != _castAddr(authorizedImpl[origin_])) {
            revert Error.INVALID_SRC_SENDER();
        }

        bytes32 hash = keccak256(body_);

        if (processedMessages[hash]) {
            revert Error.DUPLICATE_PAYLOAD();
        }

        processedMessages[hash] = true;

        /// @dev decoding payload
        AMBMessage memory decoded = abi.decode(body_, (AMBMessage));

        /// NOTE: experimental split of registry contracts
        (,,, uint8 registryId,,) = decoded.txInfo.decodeTxInfo();
        IBaseStateRegistry targetRegistry = IBaseStateRegistry(superRegistry.getStateRegistry(registryId));

        uint64 origin = superChainId[origin_];

        if (origin == 0) {
            revert Error.INVALID_CHAIN_ID();
        }

        _ambProtect(decoded);
        targetRegistry.receivePayload(origin, body_);
    }

    //////////////////////////////////////////////////////////////
    //                  INTERNAL FUNCTIONS                      //
    //////////////////////////////////////////////////////////////

    /// @dev casts an address to bytes32
    /// @param addr_ is the address to be casted
    /// @return a bytes32 casted variable of the address passed in params
    function _castAddr(address addr_) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr_)));
    }

    /// @dev casts superform extraData to hyperlane hook metadata
    function _generateHookMetadata(
        bytes memory extraData_,
        address srcSender_
    )
        internal
        pure
        returns (bytes memory hookMetaData)
    {
        if (extraData_.length != 0) {
            // extra data is encoded gas limit on dst chain
            uint256 gasLimit = abi.decode(extraData_, (uint256));
            hookMetaData = StandardHookMetadata.formatMetadata(gasLimit, srcSender_);
        }
    }

    /// @dev prevents the same AMB from delivery a payload and its proof
    /// @dev is an additional protection against malicious ambs
    function _ambProtect(AMBMessage memory _message) internal {
        bytes32 proof;

        /// @dev amb protect
        if (_message.params.length != 32) {
            (, bytes memory payloadBody) = abi.decode(_message.params, (uint8[], bytes));
            proof = AMBMessage(_message.txInfo, payloadBody).computeProof();
        } else {
            proof = abi.decode(_message.params, (bytes32));
        }

        if (ambProtect[proof]) revert MALICIOUS_DELIVERY();
        ambProtect[proof] = true;
    }
}
