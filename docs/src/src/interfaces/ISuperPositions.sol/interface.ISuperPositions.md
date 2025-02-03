# ISuperPositions
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/ISuperPositions.sol)

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

