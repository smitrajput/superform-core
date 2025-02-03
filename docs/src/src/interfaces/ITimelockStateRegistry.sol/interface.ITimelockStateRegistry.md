# ITimelockStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/ITimelockStateRegistry.sol)

**Author:**
ZeroPoint Labs

Interface for Two Steps Form State Registry


## Functions
### receivePayload

Receives request (payload) from two steps form to process later


```solidity
function receivePayload(
    uint8 type_,
    address srcSender_,
    uint64 srcChainId_,
    uint256 lockedTill_,
    InitSingleVaultData memory data_
)
    external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`type_`|`uint8`|is the nature of transaction (xChain: 1 or same chain: 0)|
|`srcSender_`|`address`|is the address of the source chain caller|
|`srcChainId_`|`uint64`|is the chainId of the source chain|
|`lockedTill_`|`uint256`|is the deadline for timelock (after which we can call `finalizePayload`)|
|`data_`|`InitSingleVaultData`|is the basic information of superformId, amount to withdraw of type InitSingleVaultData|


### finalizePayload

Form Keeper finalizes payload to process two steps withdraw fully


```solidity
function finalizePayload(uint256 payloadId_, bytes memory txData_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the id of the payload to finalize|
|`txData_`|`bytes`|is the off-chain generated transaction data|


### getTimelockPayload

*allows users to read the timeLockPayload_ stored per payloadId_*


```solidity
function getTimelockPayload(uint256 payloadId_) external view returns (TimelockPayload memory timeLockPayload_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the unqiue payload identifier allocated on the destination chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`timeLockPayload_`|`TimelockPayload`|the timelock payload stored|


### timelockPayloadCounter

*allows users to read the timelockPayloadCounter*


```solidity
function timelockPayloadCounter() external view returns (uint256);
```

