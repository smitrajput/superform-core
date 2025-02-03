# SuperPositions
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/SuperPositions.sol)

**Inherits:**
[ISuperPositions](/src/interfaces/ISuperPositions.sol/interface.ISuperPositions.md), ERC1155A, [StateSyncer](/src/StateSyncer.sol/abstract.StateSyncer.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0


## State Variables
### dynamicURI
*is the base uri set by admin*


```solidity
string public dynamicURI;
```


### dynamicURIFrozen
*is the base uri frozen status*


```solidity
bool public dynamicURIFrozen;
```


## Functions
### onlyMinter

*minters can be router with id 1 (or) state registry for that beacon*


```solidity
modifier onlyMinter(uint256 superformId) override;
```

### onlyBatchMinter

if registry id is 1 (or) corresponding state registry can mint

*minters can be router with id 1 (or) state registry for that beacon*


```solidity
modifier onlyBatchMinter(uint256[] memory superformIds) override;
```

### onlyBurner

if registry id is 1 (or) corresponding state registry can mint

*only routers with id 1 can burn super positions*


```solidity
modifier onlyBurner() override;
```

### constructor


```solidity
constructor(
    string memory dynamicURI_,
    address superRegistry_,
    uint8 routerType_
)
    StateSyncer(superRegistry_, routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dynamicURI_`|`string`| URL for external metadata of ERC1155 SuperPositions|
|`superRegistry_`|`address`|the superform registry contract|
|`routerType_`|`uint8`|the router type|


### mintSingle

*allows minter to mint shares on source*


```solidity
function mintSingle(
    address srcSender_,
    uint256 id_,
    uint256 amount_
)
    external
    override(IStateSyncer, StateSyncer)
    onlyMinter(id_);
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
function mintBatch(
    address srcSender_,
    uint256[] memory ids_,
    uint256[] memory amounts_
)
    external
    override(IStateSyncer, StateSyncer)
    onlyBatchMinter(ids_);
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
function burnSingle(
    address srcSender_,
    uint256 id_,
    uint256 amount_
)
    external
    override(IStateSyncer, StateSyncer)
    onlyBurner;
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
function burnBatch(
    address srcSender_,
    uint256[] memory ids_,
    uint256[] memory amounts_
)
    external
    override(IStateSyncer, StateSyncer)
    onlyBurner;
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
function stateMultiSync(AMBMessage memory data_)
    external
    override(IStateSyncer, StateSyncer)
    returns (uint64 srcChainId_);
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

*here we decode the txInfo and params from the data brought back from destination*

*decode remaining info on superPositions to mint from destination*

*decode initial payload info stored on source chain in this contract*

*verify this is a single vault mint*

*compare final shares beneficiary to be the same (dst/src)*

*compare txType to be the same (dst/src)*

*mint super positions accordingly*


```solidity
function stateSync(AMBMessage memory data_) external override(IStateSyncer, StateSyncer) returns (uint64 srcChainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`AMBMessage`|is the received information to be processed.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the decoded srcChainId.|


### setDynamicURI

*here we decode the txInfo and params from the data brought back from destination*

*decode remaining info on superPositions to mint from destination*

*decode initial payload info stored on source chain in this contract*

*verify this is a multi vault mint*

*compare final shares beneficiary to be the same (dst/src)*

*compare txType to be the same (dst/src)*

*mint super positions accordingly*


```solidity
function setDynamicURI(string memory dynamicURI_, bool freeze_) external override onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dynamicURI_`|`string`|is the dynamic uri of the NFT|
|`freeze_`|`bool`|is to prevent updating the metadata once migrated to IPFS|


### supportsInterface

*Implementation copied from solmate/ERC1155*


```solidity
function supportsInterface(bytes4 interfaceId_) public view virtual override(ERC1155A) returns (bool);
```

### _baseURI

Used to construct return url


```solidity
function _baseURI() internal view override returns (string memory);
```

