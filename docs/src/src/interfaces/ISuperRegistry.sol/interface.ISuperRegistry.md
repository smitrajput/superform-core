# ISuperRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/ISuperRegistry.sol)

**Author:**
Zeropoint Labs.

*interface for Super Registry*


## Functions
### setDelay

*sets the deposit rescue delay*


```solidity
function setDelay(uint256 delay_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`delay_`|`uint256`|the delay in seconds before the deposit rescue can be finalized|


### setPermit2

*sets the permit2 address*


```solidity
function setPermit2(address permit2_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`permit2_`|`address`|the address of the permit2 contract|


### setAddress

*sets a new address on a specific chain.*


```solidity
function setAddress(bytes32 id_, address newAddress_, uint64 chainId_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`bytes32`|the identifier of the address on that chain|
|`newAddress_`|`address`|the new address on that chain|
|`chainId_`|`uint64`|the chain id of that chain|


### setBridgeAddresses

this function operates in an APPEND-ONLY fashion.

*allows admin to set the bridge address for an bridge id.*


```solidity
function setBridgeAddresses(
    uint8[] memory bridgeId_,
    address[] memory bridgeAddress_,
    address[] memory bridgeValidator_
)
    external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridgeId_`|`uint8[]`|        represents the bridge unqiue identifier.|
|`bridgeAddress_`|`address[]`|   represents the bridge address.|
|`bridgeValidator_`|`address[]`| represents the bridge validator address.|


### setAmbAddress

this function operates in an APPEND-ONLY fashion.

*allows admin to set the amb address for an amb id.*


```solidity
function setAmbAddress(uint8[] memory ambId_, address[] memory ambAddress_, bool[] memory isBroadcastAMB_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8[]`|        represents the bridge unqiue identifier.|
|`ambAddress_`|`address[]`|   represents the bridge address.|
|`isBroadcastAMB_`|`bool[]`|represents whether the amb implementation supports broadcasting|


### setStateRegistryAddress

this function operates in an APPEND-ONLY fashion.

*allows admin to set the state registry address for an state registry id.*


```solidity
function setStateRegistryAddress(uint8[] memory registryId_, address[] memory registryAddress_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`registryId_`|`uint8[]`|   represents the state registry's unqiue identifier.|
|`registryAddress_`|`address[]`|   represents the state registry's address.|


### setRouterInfo

this function operates in an APPEND-ONLY fashion.

*allows admin to set the superform routers info*


```solidity
function setRouterInfo(
    uint8[] memory superformRouterIds_,
    address[] memory stateSyncers_,
    address[] memory routers_
)
    external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformRouterIds_`|`uint8[]`|   represents the superform router's unqiue identifier.|
|`stateSyncers_`|`address[]`|   represents the state syncer's address.|
|`routers_`|`address[]`|   represents the router's address.|


### delay

*gets the deposit rescue delay*


```solidity
function delay() external view returns (uint256);
```

### PERMIT2

*returns the permit2 address*


```solidity
function PERMIT2() external view returns (address);
```

### SUPERFORM_ROUTER

*returns the id of the super router module*


```solidity
function SUPERFORM_ROUTER() external view returns (bytes32);
```

### SUPERFORM_FACTORY

*returns the id of the superform factory module*


```solidity
function SUPERFORM_FACTORY() external view returns (bytes32);
```

### SUPER_TRANSMUTER

*returns the id of the superform transmuter*


```solidity
function SUPER_TRANSMUTER() external view returns (bytes32);
```

### PAYMASTER

*returns the id of the superform paymaster contract*


```solidity
function PAYMASTER() external view returns (bytes32);
```

### PAYMENT_HELPER

*returns the id of the superform payload helper contract*


```solidity
function PAYMENT_HELPER() external view returns (bytes32);
```

### CORE_STATE_REGISTRY

*returns the id of the core state registry module*


```solidity
function CORE_STATE_REGISTRY() external view returns (bytes32);
```

### TIMELOCK_STATE_REGISTRY

*returns the id of the two steps form state registry module*


```solidity
function TIMELOCK_STATE_REGISTRY() external view returns (bytes32);
```

### BROADCAST_REGISTRY

*returns the id of the broadcast state registry module*


```solidity
function BROADCAST_REGISTRY() external view returns (bytes32);
```

### SUPER_POSITIONS

*returns the id of the super positions module*


```solidity
function SUPER_POSITIONS() external view returns (bytes32);
```

### SUPER_RBAC

*returns the id of the super rbac module*


```solidity
function SUPER_RBAC() external view returns (bytes32);
```

### PAYLOAD_HELPER

*returns the id of the payload helper module*


```solidity
function PAYLOAD_HELPER() external view returns (bytes32);
```

### DST_SWAPPER

*returns the id of the dst swapper keeper*


```solidity
function DST_SWAPPER() external view returns (bytes32);
```

### EMERGENCY_QUEUE

*returns the id of the emergency queue*


```solidity
function EMERGENCY_QUEUE() external view returns (bytes32);
```

### PAYMENT_ADMIN

*returns the id of the payment admin keeper*


```solidity
function PAYMENT_ADMIN() external view returns (bytes32);
```

### CORE_REGISTRY_PROCESSOR

*returns the id of the core state registry processor keeper*


```solidity
function CORE_REGISTRY_PROCESSOR() external view returns (bytes32);
```

### BROADCAST_REGISTRY_PROCESSOR

*returns the id of the broadcast registry processor keeper*


```solidity
function BROADCAST_REGISTRY_PROCESSOR() external view returns (bytes32);
```

### TIMELOCK_REGISTRY_PROCESSOR

*returns the id of the two steps form state registry processor keeper*


```solidity
function TIMELOCK_REGISTRY_PROCESSOR() external view returns (bytes32);
```

### CORE_REGISTRY_UPDATER

*returns the id of the core state registry updater keeper*


```solidity
function CORE_REGISTRY_UPDATER() external view returns (bytes32);
```

### CORE_REGISTRY_RESCUER

*returns the id of the core state registry updater keeper*


```solidity
function CORE_REGISTRY_RESCUER() external view returns (bytes32);
```

### CORE_REGISTRY_DISPUTER

*returns the id of the core state registry updater keeper*


```solidity
function CORE_REGISTRY_DISPUTER() external view returns (bytes32);
```

### DST_SWAPPER_PROCESSOR

*returns the id of the core state registry updater keeper*


```solidity
function DST_SWAPPER_PROCESSOR() external view returns (bytes32);
```

### getAddress

*gets the address of a contract on current chain*


```solidity
function getAddress(bytes32 id_) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`bytes32`|is the id of the contract|


### getAddressByChainId

*gets the address of a contract on a target chain*


```solidity
function getAddressByChainId(bytes32 id_, uint64 chainId_) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`bytes32`|is the id of the contract|
|`chainId_`|`uint64`|is the chain id of that chain|


### getBridgeAddress

*gets the address of a bridge*


```solidity
function getBridgeAddress(uint8 bridgeId_) external view returns (address bridgeAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridgeId_`|`uint8`|is the id of a bridge|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridgeAddress_`|`address`|is the address of the form|


### getStateRegistry

*gets the address of the registry*


```solidity
function getStateRegistry(uint8 registryId_) external view returns (address registryAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`registryId_`|`uint8`|is the id of the state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`registryAddress_`|`address`|is the address of the state registry|


### getAmbId

*gets the id of the amb*


```solidity
function getAmbId(address ambAddress_) external view returns (uint8 ambId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of an amb|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8`|is the identifier of an amb|


### getStateRegistryId

reverts if the id is not found

*gets the id of the registry*


```solidity
function getStateRegistryId(address registryAddress_) external view returns (uint8 registryId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`registryAddress_`|`address`|is the address of the state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`registryId_`|`uint8`|is the id of the state registry|


### getStateSyncer

*gets the address of a state syncer*


```solidity
function getStateSyncer(uint8 superformRouterId_) external view returns (address stateSyncer_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformRouterId_`|`uint8`|is the id of a state syncer|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`stateSyncer_`|`address`|is the address of a state syncer|


### getRouter

*gets the address of a router*


```solidity
function getRouter(uint8 superformRouterId_) external view returns (address router_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformRouterId_`|`uint8`|is the id of a state syncer|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`router_`|`address`|is the address of a router|


### getSuperformRouterId

*gets the id of a router*


```solidity
function getSuperformRouterId(address router_) external view returns (uint8 superformRouterId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`router_`|`address`|is the address of a router|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`superformRouterId_`|`uint8`|is the id of a superform router / state syncer|


### isValidStateRegistry

*helps validate if an address is a valid state registry*


```solidity
function isValidStateRegistry(address registryAddress_) external view returns (bool valid_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`registryAddress_`|`address`|is the address of the state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`valid_`|`bool`|a flag indicating if its valid.|


### isValidAmbImpl

*helps validate if an address is a valid amb implementation*


```solidity
function isValidAmbImpl(address ambAddress_) external view returns (bool valid_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of the amb implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`valid_`|`bool`|a flag indicating if its valid.|


### isValidBroadcastAmbImpl

*helps validate if an address is a valid broadcast amb implementation*


```solidity
function isValidBroadcastAmbImpl(address ambAddress_) external view returns (bool valid_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of the broadcast amb implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`valid_`|`bool`|a flag indicating if its valid.|


### getBridgeValidator

*gets the address of a bridge validator*


```solidity
function getBridgeValidator(uint8 bridgeId_) external view returns (address bridgeValidator_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridgeId_`|`uint8`|is the id of a bridge|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridgeValidator_`|`address`|is the address of the form|


### getAmbAddress

*gets the address of a amb*


```solidity
function getAmbAddress(uint8 ambId_) external view returns (address ambAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8`|is the id of a bridge|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of the form|


## Events
### SetPermit2
*emitted when permit2 is set.*


```solidity
event SetPermit2(address indexed permit2);
```

### AddressUpdated
*is emitted when an address is set.*


```solidity
event AddressUpdated(
    bytes32 indexed protocolAddressId, uint64 indexed chainId, address indexed oldAddress, address newAddress
);
```

### SetBridgeAddress
*is emitted when a new token bridge is configured.*


```solidity
event SetBridgeAddress(uint256 indexed bridgeId, address indexed bridgeAddress);
```

### SetBridgeValidator
*is emitted when a new bridge validator is configured.*


```solidity
event SetBridgeValidator(uint256 indexed bridgeId, address indexed bridgeValidator);
```

### SetAmbAddress
*is emitted when a new amb is configured.*


```solidity
event SetAmbAddress(uint8 ambId_, address ambAddress_, bool isBroadcastAMB_);
```

### SetStateRegistryAddress
*is emitted when a new state registry is configured.*


```solidity
event SetStateRegistryAddress(uint8 registryId_, address registryAddress_);
```

### SetRouterInfo
*is emitted when a new router/state syncer is configured.*


```solidity
event SetRouterInfo(uint8 superFormRouterId_, address stateSyncer_, address router_);
```

### SetDelay
*is emitted when a new delay is configured.*


```solidity
event SetDelay(uint256 oldDelay_, uint256 newDelay_);
```

