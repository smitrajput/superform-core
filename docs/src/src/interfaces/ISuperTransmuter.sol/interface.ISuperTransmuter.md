# ISuperTransmuter
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/ISuperTransmuter.sol)

**Inherits:**
[IStateSyncer](/src/interfaces/IStateSyncer.sol/interface.IStateSyncer.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*interface for Super Transmuter*


## Functions
### registerTransmuter

this overrides registerTransmuter from original transmuter implementation so that users cannot insert
name, symbol, and decimals

*anyone can register a transmuter for an existent superform*


```solidity
function registerTransmuter(uint256 superformId, bytes memory extraData_) external returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformId`|`uint256`|the superform to register a transmuter for|
|`extraData_`|`bytes`|is an optional param to broadcast changes to all chains|


### stateSyncBroadcast

*allows sync register new superform ids using broadcast state registry*


```solidity
function stateSyncBroadcast(bytes memory data_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|is the crosschain payload|


