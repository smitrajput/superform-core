# CoreStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/extensions/CoreStateRegistry.sol)

**Inherits:**
[BaseStateRegistry](/src/crosschain-data/BaseStateRegistry.sol/abstract.BaseStateRegistry.md), [ICoreStateRegistry](/src/interfaces/ICoreStateRegistry.sol/interface.ICoreStateRegistry.md)

**Author:**
Zeropoint Labs

*enables communication between Superform Core Contracts deployed on all supported networks*


## State Variables
### failedDeposits
*just stores the superformIds that failed in a specific payload id*


```solidity
mapping(uint256 payloadId => FailedDeposit) internal failedDeposits;
```


## Functions
### onlyCoreStateRegistryProcessor


```solidity
modifier onlyCoreStateRegistryProcessor();
```

### onlyCoreStateRegistryUpdater


```solidity
modifier onlyCoreStateRegistryUpdater();
```

### onlyCoreStateRegistryRescuer


```solidity
modifier onlyCoreStateRegistryRescuer();
```

### onlySender


```solidity
modifier onlySender() override;
```

### isValidPayloadId


```solidity
modifier isValidPayloadId(uint256 payloadId_);
```

### constructor


```solidity
constructor(ISuperRegistry superRegistry_) BaseStateRegistry(superRegistry_);
```

### updateDepositPayload

*allows accounts with {CORE_STATE_REGISTRY_UPDATER_ROLE} to modify a received cross-chain deposit payload.*


```solidity
function updateDepositPayload(
    uint256 payloadId_,
    uint256[] calldata finalAmounts_
)
    external
    virtual
    override
    onlyCoreStateRegistryUpdater
    isValidPayloadId(payloadId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload to be updated.|
|`finalAmounts_`|`uint256[]`|is the amount to be updated. NOTE: amounts cannot be updated beyond user specified safe slippage limit.|


### updateWithdrawPayload

*set the new payload body*

*set new message quorum*

*re-set previous message quorum to 0*

*if payload is processed at this stage then it is failing*


```solidity
function updateWithdrawPayload(
    uint256 payloadId_,
    bytes[] calldata txData_
)
    external
    virtual
    override
    onlyCoreStateRegistryUpdater
    isValidPayloadId(payloadId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`| is the identifier of the cross-chain payload to be updated.|
|`txData_`|`bytes[]`|is the transaction data to be updated.|


### processPayload

*validate payload update*

*set the new payload body*

*set new message quorum*

*re-set previous message quorum to 0*

*define the payload status as updated*


```solidity
function processPayload(uint256 payloadId_)
    external
    payable
    virtual
    override
    onlyCoreStateRegistryProcessor
    isValidPayloadId(payloadId_);
```

### proposeRescueFailedDeposits

*sets status as processed to prevent re-entrancy*

*mint superPositions for successful deposits or remint for failed withdraws*

*for initial payload processing*


```solidity
function proposeRescueFailedDeposits(
    uint256 payloadId_,
    uint256[] memory proposedAmounts_
)
    external
    override
    onlyCoreStateRegistryRescuer;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload.|
|`proposedAmounts_`|`uint256[]`|is the array of proposed rescue amounts.|


### disputeRescueFailedDeposits

should challenge within the delay window configured on SuperRegistry

*allows refund receivers to challenge their final receiving token amounts on failed deposits*


```solidity
function disputeRescueFailedDeposits(uint256 payloadId_) external override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload|


### finalizeRescueFailedDeposits

is an open function & can be executed by anyone

*the msg sender should be the refund address (or) the disputer*

*the timelock is already elapsed to dispute*

*just can reset last proposed time here, since amounts should be updated again to
pass the lastProposedTimestamp zero check in finalize*


```solidity
function finalizeRescueFailedDeposits(uint256 payloadId_) external override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload|


### getFailedDeposits

*the timelock is elapsed*

*deleted to prevent re-entrancy*

*refunds the amount to user specified refund address*


```solidity
function getFailedDeposits(uint256 payloadId_)
    external
    view
    override
    returns (uint256[] memory superformIds, uint256[] memory amounts);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformIds`|`uint256[]`|superformIds_ is the identifiers of superforms in the payloadId that got failed.|
|`amounts`|`uint256[]`||


### _hasRole

*returns if an address has a specific role*


```solidity
function _hasRole(bytes32 id_, address addressToCheck_) internal view returns (bool);
```

### _getStateSyncer

*returns the state syncer address for id*


```solidity
function _getStateSyncer(uint8 id_) internal view returns (address stateSyncer);
```

### _getStateRegistryId

*returns the registry address for id*


```solidity
function _getStateRegistryId(address registryAddress_) internal view returns (uint8 id);
```

### _getAddress

*returns the address from super registry*


```solidity
function _getAddress(bytes32 id_) internal view returns (address);
```

### _getDelay

*returns the current timelock delay*


```solidity
function _getDelay() internal view returns (uint256);
```

### _getSuperRBAC

*returns the superRBAC address*


```solidity
function _getSuperRBAC() internal view returns (address);
```

### _getRequiredMessagingQuorum

*returns the required quorum for the src chain id from super registry*


```solidity
function _getRequiredMessagingQuorum(uint64 chainId_) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the src chain id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the quorum configured for the chain id|


### _getBridgeValidator

*returns the required quorum for the src chain id from super registry*


```solidity
function _getBridgeValidator(uint8 bridgeId_) internal view returns (IBridgeValidator validator);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridgeId_`|`uint8`|is the bridge id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`validator`|`IBridgeValidator`|is the address of the validator contract|


### _retrievePayloadHeaderAndBody

*retrieves information associated with the payload and validates quorum*


```solidity
function _retrievePayloadHeaderAndBody(uint256 payloadId_)
    internal
    view
    returns (
        uint256 payloadHeader_,
        bytes memory payloadBody_,
        AMBMessage memory message,
        bytes32 payloadProof,
        uint8 txType,
        uint8 callbackType,
        uint8 isMulti,
        uint8 registryId,
        address srcSender,
        uint64 srcChainId
    );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the payload id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`payloadHeader_`|`uint256`|is the payload header|
|`payloadBody_`|`bytes`|is the payload body|
|`message`|`AMBMessage`|is the AMBMessage struct|
|`payloadProof`|`bytes32`|is the payload proof|
|`txType`|`uint8`|is the transaction type|
|`callbackType`|`uint8`|is the callback type|
|`isMulti`|`uint8`|is the multi flag|
|`registryId`|`uint8`|is the registry id|
|`srcSender`|`address`|is the source sender|
|`srcChainId`|`uint64`|is the source chain id|


### _updateMultiVaultDepositPayload

*helper function to update multi vault deposit payload*


```solidity
function _updateMultiVaultDepositPayload(
    uint256 payloadId_,
    bytes memory prevPayloadBody_,
    uint256[] calldata finalAmounts_
)
    internal
    returns (bytes memory newPayloadBody_, PayloadState finalState_);
```

### _updateSingleVaultDepositPayload

*compare number of vaults to update with provided finalAmounts length*

*validate payload update*

*helper function to update single vault deposit payload*


```solidity
function _updateSingleVaultDepositPayload(
    uint256 payloadId_,
    bytes memory prevPayloadBody_,
    uint256 finalAmount_
)
    internal
    returns (bytes memory newPayloadBody_, PayloadState finalState_);
```

### _updateWithdrawPayload

*validate payload update*

*sets amount to zero and will mark the payload as UPDATED*

*sets amount to zero and will mark the payload as PROCESSED*

*helper function to update multi vault withdraw payload*


```solidity
function _updateWithdrawPayload(
    bytes memory prevPayloadBody_,
    address srcSender_,
    uint64 srcChainId_,
    bytes[] calldata txData_,
    uint8 multi
)
    internal
    view
    returns (bytes memory);
```

### _validateAndUpdateTxData

*validates the incoming update data*


```solidity
function _validateAndUpdateTxData(
    bytes[] calldata txData_,
    InitMultiVaultData memory multiVaultData_,
    address srcSender_,
    uint64 srcChainId_,
    uint64 dstChainId_
)
    internal
    view
    returns (InitMultiVaultData memory);
```

### _processMultiWithdrawal


```solidity
function _processMultiWithdrawal(
    uint256 payloadId_,
    bytes memory payload_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    returns (bytes memory);
```

### _processMultiDeposit

*it is critical to validate that the action is being performed to the correct chainId coming from
the superform*

*Store destination payloadId_ & index in extraFormData (tbd: 1-step flow doesnt need this)*

*marks the indexes that don't require a callback re-mint of shares (successful
withdraws)*

*detect if there is at least one failed withdraw*

*if at least one error happens, the shares will be re-minted for the affected superformIds*


```solidity
function _processMultiDeposit(
    uint256 payloadId_,
    bytes memory payload_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    returns (bytes memory);
```

### _processSingleWithdrawal

dstAmounts has same size of the number of vaults. If a given deposit fails, we are minting 0
SPs back on source (slight gas waste)

*it is critical to validate that the action is being performed to the correct chainId coming
from the superform*

*marks the indexes that require a callback mint of shares (successful)*

*cleaning unused approval*

*if any deposit fails, we mark errors as true and add it to failedDepositSuperformIds
mapping for future rescuing*

*issue superPositions if at least one vault deposit passed*


```solidity
function _processSingleWithdrawal(
    uint256 payloadId_,
    bytes memory payload_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    returns (bytes memory);
```

### _processSingleDeposit

*Withdraw from superform
https://solidity-by-example.org/try-catch/*


```solidity
function _processSingleDeposit(
    uint256 payloadId_,
    bytes memory payload_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    returns (bytes memory);
```

### _processAcknowledgement

*deposit to superform*

*cleaning unused approval*

*if any deposit fails, add it to failedDepositSuperformIds mapping for future rescuing*


```solidity
function _processAcknowledgement(
    uint256 payloadId_,
    bytes32 proof_,
    uint64 srcChainId_,
    bytes memory returnMessage_
)
    internal;
```

### _constructMultiReturnData

depositSync and withdrawSync internal method for sending message back to the source chain

*if deposits succeeded or some withdrawal failed, dispatch a callback*


```solidity
function _constructMultiReturnData(
    address srcSender_,
    uint256 payloadId_,
    uint8 superformRouterId_,
    TransactionType txType,
    CallbackType returnType_,
    uint256[] memory superformIds_,
    uint256[] memory amounts_
)
    internal
    view
    returns (bytes memory);
```

### _constructSingleReturnData

depositSync and withdrawSync internal method for sending message back to the source chain

*Send Data to Source to issue superform positions (failed withdraws and successful deposits)*


```solidity
function _constructSingleReturnData(
    address srcSender_,
    uint256 payloadId_,
    uint8 superformRouterId_,
    TransactionType txType,
    CallbackType returnType_,
    uint256 superformId_,
    uint256 amount_
)
    internal
    view
    returns (bytes memory);
```

### _dispatchAcknowledgement

*Send Data to Source to issue superform positions (failed withdraws and successful deposits)*

*calls the appropriate dispatch function according to the ackExtraData the keeper fed initially*


```solidity
function _dispatchAcknowledgement(uint64 dstChainId_, uint8[] memory ambIds_, bytes memory message_) internal;
```

