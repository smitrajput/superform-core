# ICoreStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/ICoreStateRegistry.sol)

**Author:**
ZeroPoint Labs

Interface for Core State Registry


## Functions
### getFailedDeposits

*allows users to read the superformIds that failed in a specific payloadId_*


```solidity
function getFailedDeposits(uint256 payloadId_)
    external
    view
    returns (uint256[] memory superformIds_, uint256[] memory amounts);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformIds_`|`uint256[]`|is the identifiers of superforms in the payloadId that got failed.|
|`amounts`|`uint256[]`||


### updateDepositPayload

*allows accounts with {CORE_STATE_REGISTRY_UPDATER_ROLE} to modify a received cross-chain deposit payload.*


```solidity
function updateDepositPayload(uint256 payloadId_, uint256[] calldata finalAmounts_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload to be updated.|
|`finalAmounts_`|`uint256[]`|is the amount to be updated. NOTE: amounts cannot be updated beyond user specified safe slippage limit.|


### updateWithdrawPayload

*allows accounts with {CORE_STATE_REGISTRY_UPDATER_ROLE} to modify a received cross-chain withdraw payload.*


```solidity
function updateWithdrawPayload(uint256 payloadId_, bytes[] calldata txData_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`| is the identifier of the cross-chain payload to be updated.|
|`txData_`|`bytes[]`|is the transaction data to be updated.|


### proposeRescueFailedDeposits

*allows accounts with {CORE_STATE_REGISTRY_PROCESSOR_ROLE} to rescue tokens on failed deposits*


```solidity
function proposeRescueFailedDeposits(uint256 payloadId_, uint256[] memory proposedAmounts_) external;
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
function disputeRescueFailedDeposits(uint256 payloadId_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload|


### finalizeRescueFailedDeposits

*allows anyone to settle refunds for unprocessed/failed deposits past the challenge period*


```solidity
function finalizeRescueFailedDeposits(uint256 payloadId_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload|


## Events
### FailedXChainDeposits
*is emitted when any deposit fails*


```solidity
event FailedXChainDeposits(uint256 indexed payloadId);
```

### RescueProposed
*is emitted when a rescue is proposed for failed deposits in a payload*


```solidity
event RescueProposed(uint256 indexed payloadId, uint256[] superformIds, uint256[] proposedAmount, uint256 proposedTime);
```

### RescueDisputed
*is emitted when an user disputed his refund amounts*


```solidity
event RescueDisputed(uint256 indexed payloadId);
```

### RescueFinalized
*is emitted when deposit rescue is finalized*


```solidity
event RescueFinalized(uint256 indexed payloadId);
```

## Structs
### CoreProcessPayloadLocalVars
*local struct to avoid stack too deep errors in `processPayload`*


```solidity
struct CoreProcessPayloadLocalVars {
    uint8 txType;
    uint8 callbackType;
    uint8 multi;
    address srcSender;
    uint64 srcChainId;
}
```

### UpdateWithdrawPayloadVars
*local struct to avoid stack too deep errors in `updateWithdrawPayload`*


```solidity
struct UpdateWithdrawPayloadVars {
    bytes32 prevPayloadProof;
    bytes prevPayloadBody;
    uint256 prevPayloadHeader;
    uint8 isMulti;
    uint64 srcChainId;
    uint64 dstChainId;
    address srcSender;
}
```

### UpdateMultiVaultWithdrawPayloadLocalVars
*local struct to avoid stack too deep errors in `updateWithdrawPayload`*


```solidity
struct UpdateMultiVaultWithdrawPayloadLocalVars {
    InitMultiVaultData multiVaultData;
    InitSingleVaultData singleVaultData;
    address superform;
    uint256[] tSuperFormIds;
    uint256[] tAmounts;
    uint256[] tMaxSlippage;
    LiqRequest[] tLiqData;
}
```

### FailedDeposit

```solidity
struct FailedDeposit {
    uint256[] superformIds;
    uint256[] amounts;
    address refundAddress;
    uint256 lastProposedTimestamp;
}
```

