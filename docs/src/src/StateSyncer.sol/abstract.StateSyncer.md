# StateSyncer
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/StateSyncer.sol)

**Inherits:**
[IStateSyncer](/src/interfaces/IStateSyncer.sol/interface.IStateSyncer.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*base contract for stateSync functions*


## State Variables
### superRegistry
*is the super registry address*


```solidity
ISuperRegistry public immutable superRegistry;
```


### ROUTER_TYPE

```solidity
uint8 public immutable ROUTER_TYPE;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### txHistory
*maps all transaction data routed through the smart contract.*


```solidity
mapping(uint256 transactionId => uint256 txInfo) public override txHistory;
```


## Functions
### onlyRouter


```solidity
modifier onlyRouter();
```

### onlyMinter


```solidity
modifier onlyMinter(uint256 id) virtual;
```

### onlyBatchMinter


```solidity
modifier onlyBatchMinter(uint256[] memory ids) virtual;
```

### onlyBurner


```solidity
modifier onlyBurner() virtual;
```

### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### constructor


```solidity
constructor(address superRegistry_, uint8 routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|
|`routerType_`|`uint8`|the router type|


### updateTxHistory

*saves the message being sent together with the associated id formulated in a router*


```solidity
function updateTxHistory(uint256 payloadId_, uint256 txInfo_) external override onlyRouter;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the id of the message being saved|
|`txInfo_`|`uint256`|is the relevant information of the transaction being saved|


### mintSingle

*allows minter to mint shares on source*


```solidity
function mintSingle(address srcSender_, uint256 id_, uint256 amount_) external virtual override;
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
function mintBatch(address srcSender_, uint256[] memory ids_, uint256[] memory amounts_) external virtual override;
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
function burnSingle(address srcSender_, uint256 id_, uint256 amount_) external virtual override;
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
function burnBatch(address srcSender_, uint256[] memory ids_, uint256[] memory amounts_) external virtual override;
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
function stateMultiSync(AMBMessage memory data_) external virtual override returns (uint64 srcChainId_);
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
function stateSync(AMBMessage memory data_) external virtual override returns (uint64 srcChainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`AMBMessage`|is the received information to be processed.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the decoded srcChainId.|


### _validateStateSyncer

*helps validate the state registry id for minting superform id*


```solidity
function _validateStateSyncer(uint256 superformId_) internal view;
```

### _validateStateSyncer

*helps validate the state registry id for minting superform id*


```solidity
function _validateStateSyncer(uint256[] memory superformIds_) internal view;
```

### _isValidStateSyncer


```solidity
function _isValidStateSyncer(uint8 registryId_, uint256 superformId_) internal pure;
```

