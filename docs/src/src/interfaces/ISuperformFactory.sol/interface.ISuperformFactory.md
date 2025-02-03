# ISuperformFactory
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/ISuperformFactory.sol)

**Author:**
ZeroPoint Labs

Interface for Superform Factory


## Functions
### addFormImplementation

*allows an admin to add a Form implementation to the factory*


```solidity
function addFormImplementation(address formImplementation_, uint32 formImplementationId_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementation_`|`address`|is the address of a form implementation|
|`formImplementationId_`|`uint32`|is the id of the form implementation (generated off-chain and equal in all chains)|


### createSuperform

*To add new vaults to Form implementations, fusing them together into Superforms*


```solidity
function createSuperform(
    uint32 formImplementationId_,
    address vault_
)
    external
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


### stateSyncBroadcast

*to synchronize superforms added to different chains using broadcast registry*


```solidity
function stateSyncBroadcast(bytes memory data_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|is the cross-chain superform id|


### changeFormImplementationPauseStatus

*allows an admin to change the status of a form*


```solidity
function changeFormImplementationPauseStatus(
    uint32 formImplementationId_,
    bool status_,
    bytes memory extraData_
)
    external
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|
|`status_`|`bool`|is the new status|
|`extraData_`|`bytes`|is optional & passed when broadcasting of status is needed|


### getFormImplementation

*returns the address of a form implementation*


```solidity
function getFormImplementation(uint32 formImplementationId_) external view returns (address formImplementation_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`formImplementation_`|`address`|is the address of the form implementation|


### isFormImplementationPaused

*returns the paused status of form implementation*


```solidity
function isFormImplementationPaused(uint32 formImplementationId_) external view returns (bool paused_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId_`|`uint32`|is the id of the form implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`paused_`|`bool`|is the current paused status of the form formImplementationId_|


### getSuperform

*returns the address of a superform*


```solidity
function getSuperform(uint256 superformId_)
    external
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
|`formImplementationId_`|`uint32`|is the id of the form implementation|
|`chainId_`|`uint64`|is the chain id|


### getAllSuperformsFromVault

*Reverse query of getSuperform, returns all superforms for a given vault*


```solidity
function getAllSuperformsFromVault(address vault_)
    external
    view
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


### getAllSuperforms

*Returns all Superforms*


```solidity
function getAllSuperforms() external view returns (uint256[] memory superformIds_, address[] memory vaults_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformIds_`|`uint256[]`|is the id of the superform|
|`vaults_`|`address[]`|is the address of the vault|


### getFormCount

*returns the number of forms*


```solidity
function getFormCount() external view returns (uint256 forms_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`forms_`|`uint256`|is the number of forms|


### getSuperformCount

*returns the number of superforms*


```solidity
function getSuperformCount() external view returns (uint256 superforms_);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superforms_`|`uint256`|is the number of superforms|


## Events
### FormImplementationAdded
*emitted when a new formImplementation is entered into the factory*


```solidity
event FormImplementationAdded(address indexed formImplementation, uint256 indexed formImplementationId);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementation`|`address`|is the address of the new form implementation|
|`formImplementationId`|`uint256`|is the id of the formImplementation|

### SuperformCreated
*emitted when a new Superform is created*


```solidity
event SuperformCreated(
    uint256 indexed formImplementationId, address indexed vault, uint256 indexed superformId, address superform
);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`formImplementationId`|`uint256`|is the id of the form implementation|
|`vault`|`address`|is the address of the vault|
|`superformId`|`uint256`|is the id of the superform|
|`superform`|`address`|is the address of the superform|

### SuperRegistrySet
*emitted when a new SuperRegistry is set*


```solidity
event SuperRegistrySet(address indexed superRegistry);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry`|`address`|is the address of the super registry|

