# ISuperTransmuter
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/ISuperTransmuter.sol)

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


