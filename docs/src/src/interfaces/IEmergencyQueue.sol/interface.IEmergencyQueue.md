# IEmergencyQueue
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/IEmergencyQueue.sol)

SPDX-License-Identifier: Apache-2.0


## Functions
### queueWithdrawal

*called by paused forms to queue up withdrawals for exit*


```solidity
function queueWithdrawal(InitSingleVaultData memory data_, address srcSender_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`InitSingleVaultData`|is the single vault data passed by the user|
|`srcSender_`|`address`||


### executeQueuedWithdrawal

*alled by emergency admin to processed queued withdrawal*


```solidity
function executeQueuedWithdrawal(uint256 id_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`uint256`|is the identifier of the queued action|


### batchExecuteQueuedWithdrawal

*called by emergency admin to batch process queued withdrawals*


```solidity
function batchExecuteQueuedWithdrawal(uint256[] memory ids_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ids_`|`uint256[]`|is the array of identifiers of the queued actions|


### queuedWithdrawalStatus

*returns the execution status of an id in the emergency queue*


```solidity
function queuedWithdrawalStatus(uint256 id) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id`|`uint256`|is the identifier of the queued action|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|boolean representing the execution status|


## Events
### WithdrawalQueued

```solidity
event WithdrawalQueued(
    address indexed srcAddress,
    address indexed refundAddress,
    uint256 indexed id,
    uint256 superformId,
    uint256 amount,
    uint256 srcPayloadId
);
```

### WithdrawalProcessed

```solidity
event WithdrawalProcessed(address indexed refundAddress, uint256 indexed id, uint256 superformId, uint256 amount);
```

