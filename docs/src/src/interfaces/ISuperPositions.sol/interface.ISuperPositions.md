# ISuperPositions
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/ISuperPositions.sol)

**Inherits:**
[IStateSyncer](/src/interfaces/IStateSyncer.sol/interface.IStateSyncer.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*interface for Super Positions*


## Functions
### setDynamicURI

*sets the dynamic uri for NFT*


```solidity
function setDynamicURI(string memory dynamicURI_, bool freeze_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dynamicURI_`|`string`|is the dynamic uri of the NFT|
|`freeze_`|`bool`|is to prevent updating the metadata once migrated to IPFS|


## Events
### DynamicURIUpdated
*is emitted when a dynamic uri is updated*


```solidity
event DynamicURIUpdated(string oldURI, string newURI, bool frozen);
```

