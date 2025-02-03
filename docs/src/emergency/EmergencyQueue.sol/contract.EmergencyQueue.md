# EmergencyQueue
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/emergency/EmergencyQueue.sol)

**Inherits:**
[IEmergencyQueue](/src/interfaces/IEmergencyQueue.sol/interface.IEmergencyQueue.md)

**Author:**
Zeropoint Labs

SPDX-License-Identifier: Apache-2.0

*stores withdrawal requests when forms are paused*


## State Variables
### CHAIN_ID
*is the chain id*


```solidity
uint64 public immutable CHAIN_ID;
```


### superRegistry
*is the address of super registry*


```solidity
ISuperRegistry public immutable superRegistry;
```


### queueCounter
*is the count of actions queued*


```solidity
uint256 public queueCounter;
```


### queuedWithdrawal
*is the queue of pending actions*


```solidity
mapping(uint256 id => QueuedWithdrawal) public queuedWithdrawal;
```


## Functions
### onlySuperform


```solidity
modifier onlySuperform(uint256 superformId_);
```

### onlyEmergencyAdmin


```solidity
modifier onlyEmergencyAdmin();
```

### constructor


```solidity
constructor(address superRegistry_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|


### queueWithdrawal

*called by paused forms to queue up withdrawals for exit*


```solidity
function queueWithdrawal(
    InitSingleVaultData memory data_,
    address srcSender_
)
    external
    override
    onlySuperform(data_.superformId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`InitSingleVaultData`|is the single vault data passed by the user|
|`srcSender_`|`address`||


### executeQueuedWithdrawal

*alled by emergency admin to processed queued withdrawal*


```solidity
function executeQueuedWithdrawal(uint256 id_) public override onlyEmergencyAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`uint256`|is the identifier of the queued action|


### batchExecuteQueuedWithdrawal


```solidity
function batchExecuteQueuedWithdrawal(uint256[] memory ids_) external override onlyEmergencyAdmin;
```

### queuedWithdrawalStatus

*returns the execution status of an id in the emergency queue*


```solidity
function queuedWithdrawalStatus(uint256 id) external view override returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id`|`uint256`|is the identifier of the queued action|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|boolean representing the execution status|


