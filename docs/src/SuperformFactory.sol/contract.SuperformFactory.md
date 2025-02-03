# SuperformFactory
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/SuperformFactory.sol)

**Inherits:**
[ISuperformFactory](/src/interfaces/ISuperformFactory.sol/interface.ISuperformFactory.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*A secure, and easily queryable central point of access for all Superforms on any given chain,*


## State Variables
### SYNC_IMPLEMENTATION_STATUS

```solidity
bytes32 constant SYNC_IMPLEMENTATION_STATUS = keccak256("SYNC_IMPLEMENTATION_STATUS");
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### xChainPayloadCounter

```solidity
uint256 public xChainPayloadCounter;
```


### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### formImplementations
*all form beacon addresses*


```solidity
address[] public formImplementations;
```


### superforms
*all superform ids*


```solidity
uint256[] public superforms;
```


### formImplementation
If formImplementationId is 0, formImplementation is not part of the protocol


```solidity
mapping(uint32 formImplementationId => address formBeaconAddress) public formImplementation;
```


### formImplementationPaused

```solidity
mapping(uint32 formImplementationId => bool paused) public formImplementationPaused;
```


### vaultToSuperforms

```solidity
mapping(address vault => uint256[] superformIds) public vaultToSuperforms;
```


### vaultToFormImplementationId

```solidity
mapping(address vault => uint256[] formImplementationId) public vaultToFormImplementationId;
```


### vaultFormImplCombinationToSuperforms

```solidity
mapping(bytes32 vaultFormImplementationCombination => uint256 superformIds) public vaultFormImplCombinationToSuperforms;
```


## Functions
### onlyEmergencyAdmin


```solidity
modifier onlyEmergencyAdmin();
```

### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### constructor


```solidity
constructor(address superRegistry_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|


### addFormImplementation

*allows an admin to add a Form implementation to the factory*


```solidity
function addFormImplementation(
    address formImplementation_,
    uint32 formImplementationId_
)
    public
    override
    onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementation_`|`address`|is the address of a form implementation|
|`formImplementationId_`|`uint32`|is the id of the form implementation (generated off-chain and equal in all chains)|


### createSuperform

*save the newly added address in the mapping and array registry*


```solidity
function createSuperform(
    uint32 formImplementationId_,
    address vault_
)
    public
    override
    returns (uint256 superformId_, address superform_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the form implementation we want to attach the vault to|
|`vault_`|`address`|is the address of the vault|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformId_`|`uint256`|is the id of the created superform|
|`superform_`|`address`|is the address of the created superform|


### changeFormImplementationPauseStatus

*Same vault and beacon can be used only once to create superform*

*instantiate the superform.*

*this will always be unique because all chainIds are unique*

*Mapping vaults to formImplementationId for use in Backend*


```solidity
function changeFormImplementationPauseStatus(
    uint32 formImplementationId_,
    bool paused_,
    bytes memory extraData_
)
    external
    payable
    override
    onlyEmergencyAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|
|`paused_`|`bool`||
|`extraData_`|`bytes`|is optional & passed when broadcasting of status is needed|


### stateSyncBroadcast

*broadcast the change in status to the other destination chains*


```solidity
function stateSyncBroadcast(bytes memory data_) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|is the cross-chain superform id|


### getFormImplementation

*this function is only accessible through broadcast registry*


```solidity
function getFormImplementation(uint32 formImplementationId_) external view override returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|formImplementation_ is the address of the form implementation|


### isFormImplementationPaused

*returns the paused status of form implementation*


```solidity
function isFormImplementationPaused(uint32 formImplementationId_) external view override returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|paused_ is the current paused status of the form formImplementationId_|


### getAllSuperformsFromVault

*Reverse query of getSuperform, returns all superforms for a given vault*


```solidity
function getAllSuperformsFromVault(address vault_)
    external
    view
    override
    returns (uint256[] memory superformIds_, address[] memory superforms_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`vault_`|`address`|is the address of a vault|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformIds_`|`uint256[]`|is the id of the superform|
|`superforms_`|`address[]`|is the address of the superform|


### getSuperform

*returns the address of a superform*


```solidity
function getSuperform(uint256 superformId_)
    external
    pure
    override
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
|`formImplementationId_`|`uint32`|is the id of the form implementation|
|`chainId_`|`uint64`|is the chain id|


### getAllSuperforms

*Returns all Superforms*


```solidity
function getAllSuperforms()
    external
    view
    override
    returns (uint256[] memory superformIds_, address[] memory superforms_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformIds_`|`uint256[]`|is the id of the superform|
|`superforms_`|`address[]`|vaults_ is the address of the vault|


### getFormCount

*returns the number of forms*


```solidity
function getFormCount() external view override returns (uint256 forms_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`forms_`|`uint256`|is the number of forms|


### getSuperformCount

*returns the number of superforms*


```solidity
function getSuperformCount() external view override returns (uint256 superforms_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superforms_`|`uint256`|is the number of superforms|


### _broadcast

*interacts with broadcast state registry to broadcasting state changes to all connected remote chains*


```solidity
function _broadcast(bytes memory message_, bytes memory extraData_) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`message_`|`bytes`|is the crosschain message to be sent.|
|`extraData_`|`bytes`|is the amb override information.|


### _syncFormPausedStatus

is a part of broadcasting / dispatching through factory state registry

*ambIds are validated inside the broadcast state registry*

*broadcastParams if wrong will revert in the amb implementation*

*synchronize paused status update message from remote chain*


```solidity
function _syncFormPausedStatus(bytes memory message_) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`message_`|`bytes`|is the crosschain message received.|


