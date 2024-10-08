///SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

import { AccessControlEnumerable } from "openzeppelin-contracts/contracts/access/AccessControlEnumerable.sol";
import { IBroadcastRegistry } from "../interfaces/IBroadcastRegistry.sol";
import { ISuperRegistry } from "../interfaces/ISuperRegistry.sol";
import { ISuperRBAC } from "../interfaces/ISuperRBAC.sol";
import { Error } from "../utils/Error.sol";
import { BroadcastMessage } from "../types/DataTypes.sol";

/// @title SuperRBAC
/// @author Zeropoint Labs.
/// @dev Contract to manage roles in the entire superform protocol
contract SuperRBAC is ISuperRBAC, AccessControlEnumerable {
    bytes32 public constant SYNC_REVOKE = keccak256("SYNC_REVOKE");

    /// @dev used in many areas of the codebase to perform config operations
    /// @dev could be worth to have this changeable in case it gets compromised (but without ability to revoke itself)
    /// @dev changeable by which role?
    /// @dev single address
    bytes32 public constant override PROTOCOL_ADMIN_ROLE = keccak256("PROTOCOL_ADMIN_ROLE");
    /// @dev used in a few areas of the code
    /// @dev could be worth to have this changeable in case it gets compromised (but without ability to revoke itself)
    /// @dev changeable by which role?
    /// @dev single address
    bytes32 public constant override EMERGENCY_ADMIN_ROLE = keccak256("EMERGENCY_ADMIN_ROLE");
    /// @dev used to extract funds from PayMaster
    /// @dev could be allowed to be changed
    /// @dev single address
    bytes32 public constant override PAYMENT_ADMIN_ROLE = keccak256("PAYMENT_ADMIN_ROLE");
    /// @dev used so that certain contracts can broadcast state changes to all connected remote chains
    /// @dev currently SUPERFORM_FACTORY, SUPERTRANSMUTER and SUPER_RBAC have this role. SUPER_RBAC doesn't need it
    /// @dev should NOT be allowed to be changed (maps to more than 1 address)
    /// @dev multi address (revoke broadcast should be restricted)
    bytes32 public constant override BROADCASTER_ROLE = keccak256("BROADCASTER_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override CORE_STATE_REGISTRY_PROCESSOR_ROLE =
        keccak256("CORE_STATE_REGISTRY_PROCESSOR_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE =
        keccak256("TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE =
        keccak256("BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override CORE_STATE_REGISTRY_UPDATER_ROLE = keccak256("CORE_STATE_REGISTRY_UPDATER_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override CORE_STATE_REGISTRY_RESCUER_ROLE = keccak256("CORE_STATE_REGISTRY_RESCUER_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override CORE_STATE_REGISTRY_DISPUTER_ROLE = keccak256("CORE_STATE_REGISTRY_DISPUTER_ROLE");
    /// @dev this is a role so that we could run multiple relayers
    /// @dev should be allowed to be changed
    /// @dev multi address (revoke broadcast should be restricted)
    bytes32 public constant override WORMHOLE_VAA_RELAYER_ROLE = keccak256("WORMHOLE_VAA_RELAYER_ROLE");
    /// @dev keeper role, should be allowed to be changed
    /// @dev single address
    bytes32 public constant override DST_SWAPPER_ROLE = keccak256("DST_SWAPPER_ROLE");

    ISuperRegistry public superRegistry;

    constructor(InitialRoleSetup memory roles) {
        _setupRole(PROTOCOL_ADMIN_ROLE, roles.admin);
        _setupRole(EMERGENCY_ADMIN_ROLE, roles.emergencyAdmin);
        _setupRole(PAYMENT_ADMIN_ROLE, roles.paymentAdmin);
        _setupRole(BROADCASTER_ROLE, address(this));
        _setupRole(CORE_STATE_REGISTRY_PROCESSOR_ROLE, roles.csrProcessor);
        _setupRole(TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE, roles.tlProcessor);
        _setupRole(BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE, roles.brProcessor);
        _setupRole(CORE_STATE_REGISTRY_UPDATER_ROLE, roles.csrUpdater);
        _setupRole(WORMHOLE_VAA_RELAYER_ROLE, roles.srcVaaRelayer);
        _setupRole(DST_SWAPPER_ROLE, roles.dstSwapper);
        _setupRole(CORE_STATE_REGISTRY_RESCUER_ROLE, roles.csrRescuer);
        _setupRole(CORE_STATE_REGISTRY_DISPUTER_ROLE, roles.csrDisputer);

        /// @dev manually set role admin to PROTOCOL_ADMIN_ROLE on all roles
        _setRoleAdmin(PROTOCOL_ADMIN_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(EMERGENCY_ADMIN_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(PAYMENT_ADMIN_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(CORE_STATE_REGISTRY_PROCESSOR_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(CORE_STATE_REGISTRY_UPDATER_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(BROADCASTER_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(WORMHOLE_VAA_RELAYER_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(DST_SWAPPER_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(CORE_STATE_REGISTRY_RESCUER_ROLE, PROTOCOL_ADMIN_ROLE);
        _setRoleAdmin(CORE_STATE_REGISTRY_DISPUTER_ROLE, PROTOCOL_ADMIN_ROLE);
    }

    /*///////////////////////////////////////////////////////////////
                        External Write Functions
    //////////////////////////////////////////////////////////////*/

    /// @inheritdoc ISuperRBAC
    function setSuperRegistry(address superRegistry_) external override onlyRole(PROTOCOL_ADMIN_ROLE) {
        superRegistry = ISuperRegistry(superRegistry_);
    }

    /// @inheritdoc ISuperRBAC
    function setRoleAdmin(bytes32 role_, bytes32 adminRole_) external override onlyRole(PROTOCOL_ADMIN_ROLE) {
        _setRoleAdmin(role_, adminRole_);
    }

    /// @inheritdoc ISuperRBAC
    function revokeRoleSuperBroadcast(
        bytes32 role_,
        address addressToRevoke_,
        bytes memory extraData_,
        bytes32 superRegistryAddressId_
    )
        external
        payable
        override
        onlyRole(PROTOCOL_ADMIN_ROLE)
    {
        /// @dev revokeRoleSuperBroadcast cannot update the PROTOCOL_ADMIN_ROLE and EMERGENCY_ADMIN_ROLE
        if (
            !(
                role_ == PROTOCOL_ADMIN_ROLE || role_ == EMERGENCY_ADMIN_ROLE || role_ == BROADCASTER_ROLE
                    || role_ == WORMHOLE_VAA_RELAYER_ROLE
            )
        ) {
            revokeRole(role_, addressToRevoke_);
        } else {
            revert Error.CANNOT_REVOKE_BROADCAST();
        }

        if (extraData_.length > 0) {
            BroadcastMessage memory rolesPayload =
                BroadcastMessage("SUPER_RBAC", SYNC_REVOKE, abi.encode(role_, superRegistryAddressId_));

            _broadcast(abi.encode(rolesPayload), extraData_);
        }
    }

    /// @inheritdoc ISuperRBAC
    function stateSyncBroadcast(bytes memory data_) external override {
        if (msg.sender != superRegistry.getAddress(keccak256("BROADCAST_REGISTRY"))) {
            revert Error.NOT_BROADCAST_REGISTRY();
        }

        BroadcastMessage memory rolesPayload = abi.decode(data_, (BroadcastMessage));

        if (rolesPayload.messageType == SYNC_REVOKE) {
            (bytes32 role, bytes32 superRegistryAddressId) = abi.decode(rolesPayload.message, (bytes32, bytes32));
            address addressToRevoke = superRegistry.getAddress(superRegistryAddressId);

            if (addressToRevoke == address(0)) revert Error.ZERO_ADDRESS();

            /// @dev broadcasting cannot update the PROTOCOL_ADMIN_ROLE and EMERGENCY_ADMIN_ROLE
            if (role != PROTOCOL_ADMIN_ROLE || role != EMERGENCY_ADMIN_ROLE) _revokeRole(role, addressToRevoke);
        }
    }

    /*///////////////////////////////////////////////////////////////
                        CONVENIENCE VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @inheritdoc ISuperRBAC
    function hasProtocolAdminRole(address admin_) external view override returns (bool) {
        if (admin_ == address(0)) return false;
        return hasRole(PROTOCOL_ADMIN_ROLE, admin_);
    }

    /// @inheritdoc ISuperRBAC
    function hasEmergencyAdminRole(address emergencyAdmin_) external view override returns (bool) {
        return hasRole(EMERGENCY_ADMIN_ROLE, emergencyAdmin_);
    }

    /*///////////////////////////////////////////////////////////////
                        Internal Functions
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Overload {_revokeRole} to track enumerable memberships
     */
    function _revokeRole(bytes32 role_, address account_) internal override {
        if (role_ == PROTOCOL_ADMIN_ROLE || role_ == EMERGENCY_ADMIN_ROLE) {
            if (getRoleMemberCount(role_) == 1) revert Error.CANNOT_REVOKE_LAST_ADMIN();
        }
        super._revokeRole(role_, account_);
    }

    /// @dev interacts with role state registry to broadcasting state changes to all connected remote chains
    /// @param message_ is the crosschain message to be sent.
    /// @param extraData_ is the amb override information.
    function _broadcast(bytes memory message_, bytes memory extraData_) internal {
        (uint8[] memory ambIds, bytes memory broadcastParams) = abi.decode(extraData_, (uint8[], bytes));

        /// @dev ambIds are validated inside the factory state registry
        /// @dev if the broadcastParams are wrong, this will revert in the amb implementation
        IBroadcastRegistry(superRegistry.getAddress(keccak256("BROADCAST_REGISTRY"))).broadcastPayload{
            value: msg.value
        }(msg.sender, ambIds, message_, broadcastParams);
    }
}
