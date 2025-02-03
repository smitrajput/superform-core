# DataLib
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/libraries/DataLib.sol)

*rationale for "memory-safe" assembly: https://docs.soliditylang.org/en/v0.8.20/assembly.html#memory-safety*


## Functions
### packTxInfo


```solidity
function packTxInfo(
    uint8 txType_,
    uint8 callbackType_,
    uint8 multi_,
    uint8 registryId_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    pure
    returns (uint256 txInfo);
```

### decodeTxInfo


```solidity
function decodeTxInfo(uint256 txInfo_)
    internal
    pure
    returns (uint8 txType, uint8 callbackType, uint8 multi, uint8 registryId, address srcSender, uint64 srcChainId);
```

### getSuperform

*returns the vault-form-chain pair of a superform*


```solidity
function getSuperform(uint256 superformId_)
    internal
    pure
    returns (address superform_, uint32 formImplementationId_, uint64 chainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformId_`|`uint256`|is the id of the superform|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superform_`|`address`|is the address of the superform|
|`formImplementationId_`|`uint32`|is the form id|
|`chainId_`|`uint64`|is the chain id|


### getSuperforms

*returns the vault-form-chain pair of an array of superforms*


```solidity
function getSuperforms(uint256[] memory superformIds_)
    internal
    pure
    returns (address[] memory superforms_, uint32[] memory formIds_, uint64[] memory chainIds_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformIds_`|`uint256[]`| array of superforms|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superforms_`|`address[]`|are the address of the vaults|
|`formIds_`|`uint32[]`|are the form ids|
|`chainIds_`|`uint64[]`|are the chain ids|


### validateSuperformChainId

*pointer to the end of the superformIds_ array (shl(5, mload(superformIds_)) == mul(32,
mload(superformIds_))*

*initialize pointers for all the 4 arrays*

*execute what getSuperform() does on a single superformId and store the results in the
respective arrays*

*increment pointers*

*check if we've reached the end of the array*

*validates if the superformId_ belongs to the chainId_*


```solidity
function validateSuperformChainId(uint256 superformId_, uint64 chainId_) internal pure;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformId_`|`uint256`|to validate|
|`chainId_`|`uint64`|is the chainId to check if the superform id belongs to|


### getDestinationChain

*validates if superformId exists on factory*

*returns the destination chain of a given superform*


```solidity
function getDestinationChain(uint256 superformId_) internal pure returns (uint64 chainId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformId_`|`uint256`|is the id of the superform|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the chain id|


### packSuperform

*generates the superformId*


```solidity
function packSuperform(
    address superform_,
    uint32 formImplementationId_,
    uint64 chainId_
)
    internal
    pure
    returns (uint256 superformId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superform_`|`address`|is the address of the superform|
|`formImplementationId_`|`uint32`|is the type of the form|
|`chainId_`|`uint64`|is the chain id on which the superform is deployed|


