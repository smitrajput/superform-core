# SuperTransmuter
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/SuperTransmuter.sol)

**Inherits:**
[ISuperTransmuter](/src/interfaces/ISuperTransmuter.sol/interface.ISuperTransmuter.md), Transmuter, [StateSyncer](/src/StateSyncer.sol/abstract.StateSyncer.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

This contract inherits from ERC1155A transmuter, changing the way transmuters are registered to only require
a superformId. Metadata is fetched from underlying vault


## State Variables
### DEPLOY_NEW_TRANSMUTER

```solidity
bytes32 constant DEPLOY_NEW_TRANSMUTER = keccak256("DEPLOY_NEW_TRANSMUTER");
```


### xChainPayloadCounter

```solidity
uint256 public xChainPayloadCounter;
```


## Functions
### onlyMinter

*minters can be router with id 2 (or) state registry for that beacon*


```solidity
modifier onlyMinter(uint256 superformId) override;
```

### onlyBatchMinter

if registry id is 2 (or) corresponding state registry can mint

*minters can be router with id 2 (or) state registry for that beacon*


```solidity
modifier onlyBatchMinter(uint256[] memory superformIds) override;
```

### onlyBurner

if registry id is 1 (or) corresponding state registry can mint

*only routers with id 2 can burn sERC20*


```solidity
modifier onlyBurner() override;
```

### constructor


```solidity
constructor(
    IERC1155A superPositions_,
    address superRegistry_,
    uint8 routerType_
)
    Transmuter(superPositions_)
    StateSyncer(superRegistry_, routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superPositions_`|`IERC1155A`|the super positions contract|
|`superRegistry_`|`address`|the superform registry contract|
|`routerType_`|`uint8`|the router type|


### registerTransmuter

explicity revert on register transmuter


```solidity
function registerTransmuter(uint256, string memory, string memory, uint8) external pure override returns (address);
```

### registerTransmuter

this overrides registerTransmuter from original transmuter implementation so that users cannot insert
name, symbol, and decimals

*anyone can register a transmuter for an existent superform*


```solidity
function registerTransmuter(uint256 superformId_, bytes memory extraData_) external override returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformId_`|`uint256`||
|`extraData_`|`bytes`|is an optional param to broadcast changes to all chains|


### mintSingle

*broadcast and deploy to the other destination chains*


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

*note each allowance check in burn needs to pass. Since we burn atomically (on SuperformRouter level),
if this loop fails, tx reverts right in the 1st stage*


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


### stateSyncBroadcast

*here we decode the txInfo and params from the data brought back from destination*

*decode remaining info on superPositions to mint from destination*

*decode initial payload info stored on source chain in this contract*

*verify this is a multi vault mint*

*compare final shares beneficiary to be the same (dst/src)*

*compare txType to be the same (dst/src)*

*mint super positions accordingly*


```solidity
function stateSyncBroadcast(bytes memory data_) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|is the crosschain payload|


### _broadcast

*this function is only accessible through broadcast registry*

*interacts with broadcast state registry to broadcasting state changes to all connected remote chains*


```solidity
function _broadcast(bytes memory message_, bytes memory extraData_) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`message_`|`bytes`|is the crosschain message to be sent.|
|`extraData_`|`bytes`|is the amb override information.|


### _deployTransmuter

*ambIds are validated inside the broadcast state registry*

*broadcastParams if wrong will revert in the amb implementation*

*deploys new transmuter on broadcasting*


```solidity
function _deployTransmuter(bytes memory message_) internal;
```

