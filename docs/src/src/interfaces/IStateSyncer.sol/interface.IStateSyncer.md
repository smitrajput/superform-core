# IStateSyncer
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/IStateSyncer.sol)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*interface for State Syncer*


## Functions
### updateTxHistory

*saves the message being sent together with the associated id formulated in a router*


```solidity
function updateTxHistory(uint256 payloadId_, uint256 txInfo_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the id of the message being saved|
|`txInfo_`|`uint256`|is the relevant information of the transaction being saved|


### mintSingle

*allows minter to mint shares on source*


```solidity
function mintSingle(address srcSender_, uint256 id_, uint256 amount_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the beneficiary of shares|
|`id_`|`uint256`|is the id of the shares|
|`amount_`|`uint256`|is the amount of shares to mint|


### mintBatch

*allows minter to mint shares on source in batch*


```solidity
function mintBatch(address srcSender_, uint256[] memory ids_, uint256[] memory amounts_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the beneficiary of shares|
|`ids_`|`uint256[]`|are the ids of the shares|
|`amounts_`|`uint256[]`|are the amounts of shares to mint|


### burnSingle

*allows burner to burn shares on source*


```solidity
function burnSingle(address srcSender_, uint256 id_, uint256 amount_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the address of the sender|
|`id_`|`uint256`|is the id of the shares|
|`amount_`|`uint256`|is the amount of shares to burn|


### burnBatch

*allows burner to burn shares on source in batch*


```solidity
function burnBatch(address srcSender_, uint256[] memory ids_, uint256[] memory amounts_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the address of the sender|
|`ids_`|`uint256[]`|are the ids of the shares|
|`amounts_`|`uint256[]`|are the amounts of shares to burn|


### stateMultiSync

*allows state registry contract to mint shares on source*


```solidity
function stateMultiSync(AMBMessage memory data_) external returns (uint64 srcChainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`AMBMessage`|is the received information to be processed.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the decoded srcChainId.|


### stateSync

*allows state registry contract to mint shares on source*


```solidity
function stateSync(AMBMessage memory data_) external returns (uint64 srcChainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`AMBMessage`|is the received information to be processed.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the decoded srcChainId.|


### txHistory

*returns the payload header for a tx id on the source chain*


```solidity
function txHistory(uint256 txId_) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txId_`|`uint256`|is the identifier of the transaction issued by super router|


## Events
### Completed
*is emitted when a cross-chain transaction is completed.*


```solidity
event Completed(uint256 txId);
```

