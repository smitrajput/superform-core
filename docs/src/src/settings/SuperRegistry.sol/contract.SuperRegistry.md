# SuperRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/settings/SuperRegistry.sol)

**Inherits:**
[ISuperRegistry](/src/interfaces/ISuperRegistry.sol/interface.ISuperRegistry.md), [QuorumManager](/src/crosschain-data/utils/QuorumManager.sol/abstract.QuorumManager.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*Keeps information on all addresses used in the Superforms ecosystem.*


## State Variables
### MIN_DELAY

```solidity
uint256 public constant MIN_DELAY = 1 hours;
```


### MAX_DELAY

```solidity
uint256 public constant MAX_DELAY = 24 hours;
```


### PERMIT2
*canonical permit2 contract*


```solidity
address public PERMIT2;
```


### delay
*rescue timelock delay config*


```solidity
uint256 public delay;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### registry

```solidity
mapping(bytes32 id => mapping(uint64 chainid => address moduleAddress)) private registry;
```


### bridgeAddresses
*bridge id is mapped to a bridge address (to prevent interaction with unauthorized bridges)*


```solidity
mapping(uint8 bridgeId => address bridgeAddress) public bridgeAddresses;
```


### bridgeValidator

```solidity
mapping(uint8 bridgeId => address bridgeValidator) public bridgeValidator;
```


### ambAddresses

```solidity
mapping(uint8 bridgeId => address ambAddresses) public ambAddresses;
```


### isBroadcastAMB

```solidity
mapping(uint8 bridgeId => bool isBroadcastAMB) public isBroadcastAMB;
```


### stateSyncers

```solidity
mapping(uint8 superformRouterId => address stateSyncer) public stateSyncers;
```


### routers

```solidity
mapping(uint8 superformRouterId => address router) public routers;
```


### registryAddresses

```solidity
mapping(uint8 registryId => address registryAddress) public registryAddresses;
```


### stateRegistryIds
*is the reverse mapping of registryAddresses*


```solidity
mapping(address registryAddress => uint8 registryId) public stateRegistryIds;
```


### ambIds
*is the reverse mapping of ambAddresses*


```solidity
mapping(address ambAddress => uint8 bridgeId) public ambIds;
```


### superformRouterIds
*is the reverse mapping of routers*


```solidity
mapping(address router => uint8 superformRouterId) public superformRouterIds;
```


### SUPERFORM_ROUTER
SUPERFORM_FACTORY, CORE_STATE_REGISTRY, TIMELOCK_STATE_REGISTRY, BROADCAST_REGISTRY, SUPER_RBAC,
DST_SWAPPER

should not be allowed to be changed

*core protocol - identifiers*

*not accessed in protocol*

*could be allowed to be changed*


```solidity
bytes32 public constant override SUPERFORM_ROUTER = keccak256("SUPERFORM_ROUTER");
```


### SUPERFORM_FACTORY
*can be used to set a new factory that has form ids paused*

*probably should NOT be allowed to be changed*


```solidity
bytes32 public constant override SUPERFORM_FACTORY = keccak256("SUPERFORM_FACTORY");
```


### SUPER_TRANSMUTER
*not accessed in protocol*

*could be allowed to be changed*


```solidity
bytes32 public constant override SUPER_TRANSMUTER = keccak256("SUPER_TRANSMUTER");
```


### PAYMASTER
*can be used to set a new paymaster to forward payments to*

*could be allowed to be changed*


```solidity
bytes32 public constant override PAYMASTER = keccak256("PAYMASTER");
```


### PAYMENT_HELPER
*accessed in some areas of the protocol to calculate AMB fees. Already has a function to alter the
configuration*

*could be allowed to be changed*


```solidity
bytes32 public constant override PAYMENT_HELPER = keccak256("PAYMENT_HELPER");
```


### CORE_STATE_REGISTRY
*accessed in many areas of the protocol. has direct access to superforms*

*should NOT be allowed to be changed*


```solidity
bytes32 public constant override CORE_STATE_REGISTRY = keccak256("CORE_STATE_REGISTRY");
```


### TIMELOCK_STATE_REGISTRY
*accessed in many areas of the protocol. has direct access to timelock form*

*should NOT be allowed to be changed*


```solidity
bytes32 public constant override TIMELOCK_STATE_REGISTRY = keccak256("TIMELOCK_STATE_REGISTRY");
```


### BROADCAST_REGISTRY
*used to sync messages for pausing superforms or deploying transmuters*

*probably should NOT be allowed to be changed*


```solidity
bytes32 public constant override BROADCAST_REGISTRY = keccak256("BROADCAST_REGISTRY");
```


### SUPER_POSITIONS
*not accessed in protocol*

*could be allowed to be changed*


```solidity
bytes32 public constant override SUPER_POSITIONS = keccak256("SUPER_POSITIONS");
```


### SUPER_RBAC
*accessed in many areas of the protocol*

*probably should NOT be allowed to be changed*


```solidity
bytes32 public constant override SUPER_RBAC = keccak256("SUPER_RBAC");
```


### PAYLOAD_HELPER
*not accessed in protocol*

*could be allowed to be changed*


```solidity
bytes32 public constant override PAYLOAD_HELPER = keccak256("PAYLOAD_HELPER");
```


### DST_SWAPPER
*accessed in CSR and validators. can be used to alter behaviour of update deposit payloads*

*probably should NOT be allowed to be changed*


```solidity
bytes32 public constant override DST_SWAPPER = keccak256("DST_SWAPPER");
```


### EMERGENCY_QUEUE
*accessed in base form to send payloads to emergency queue*

*probably should NOT be allowed to be changed*


```solidity
bytes32 public constant override EMERGENCY_QUEUE = keccak256("EMERGENCY_QUEUE");
```


### PAYMENT_ADMIN
*default keepers - identifiers*

*could be allowed to be changed*


```solidity
bytes32 public constant override PAYMENT_ADMIN = keccak256("PAYMENT_ADMIN");
```


### CORE_REGISTRY_PROCESSOR

```solidity
bytes32 public constant override CORE_REGISTRY_PROCESSOR = keccak256("CORE_REGISTRY_PROCESSOR");
```


### BROADCAST_REGISTRY_PROCESSOR

```solidity
bytes32 public constant override BROADCAST_REGISTRY_PROCESSOR = keccak256("BROADCAST_REGISTRY_PROCESSOR");
```


### TIMELOCK_REGISTRY_PROCESSOR

```solidity
bytes32 public constant override TIMELOCK_REGISTRY_PROCESSOR = keccak256("TIMELOCK_REGISTRY_PROCESSOR");
```


### CORE_REGISTRY_UPDATER

```solidity
bytes32 public constant override CORE_REGISTRY_UPDATER = keccak256("CORE_REGISTRY_UPDATER");
```


### CORE_REGISTRY_RESCUER

```solidity
bytes32 public constant override CORE_REGISTRY_RESCUER = keccak256("CORE_REGISTRY_RESCUER");
```


### CORE_REGISTRY_DISPUTER

```solidity
bytes32 public constant override CORE_REGISTRY_DISPUTER = keccak256("CORE_REGISTRY_DISPUTER");
```


### DST_SWAPPER_PROCESSOR

```solidity
bytes32 public constant override DST_SWAPPER_PROCESSOR = keccak256("DST_SWAPPER_PROCESSOR");
```


## Functions
### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### constructor


```solidity
constructor(address superRBAC_);
```

### setDelay

*sets the deposit rescue delay*


```solidity
function setDelay(uint256 delay_) external override onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`delay_`|`uint256`|the delay in seconds before the deposit rescue can be finalized|


### setPermit2

*sets the permit2 address*


```solidity
function setPermit2(address permit2_) external override onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`permit2_`|`address`|the address of the permit2 contract|


### setAddress

*sets a new address on a specific chain.*


```solidity
function setAddress(bytes32 id_, address newAddress_, uint64 chainId_) external override onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`id_`|`bytes32`|the identifier of the address on that chain|
|`newAddress_`|`address`|the new address on that chain|
|`chainId_`|`uint64`|the chain id of that chain|


### setBridgeAddresses

SUPERFORM_FACTORY, CORE_STATE_REGISTRY, TIMELOCK_STATE_REGISTRY, BROADCAST_REGISTRY, SUPER_RBAC,
DST_SWAPPER cannot be changed once set

*allows admin to set the bridge address for an bridge id.*


```solidity
function setBridgeAddresses(
    uint8[] memory bridgeId_,
    address[] memory bridgeAddress_,
    address[] memory bridgeValidator_
)
    external
    override
    onlyProtocolAdmin;
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
function setAmbAddress(
    uint8[] memory ambId_,
    address[] memory ambAddress_,
    bool[] memory isBroadcastAMB_
)
    external
    override
    onlyProtocolAdmin;
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
function setStateRegistryAddress(
    uint8[] memory registryId_,
    address[] memory registryAddress_
)
    external
    override
    onlyProtocolAdmin;
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
    external
    override
    onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superformRouterIds_`|`uint8[]`|   represents the superform router's unqiue identifier.|
|`stateSyncers_`|`address[]`|   represents the state syncer's address.|
|`routers_`|`address[]`|   represents the router's address.|


### setRequiredMessagingQuorum


```solidity
function setRequiredMessagingQuorum(uint64 srcChainId_, uint256 quorum_) external override onlyProtocolAdmin;
```

### getAddress


```solidity
function getAddress(bytes32 id_) external view override returns (address);
```

### getAddressByChainId


```solidity
function getAddressByChainId(bytes32 id_, uint64 chainId_) external view override returns (address);
```

### getBridgeAddress

*gets the address of a bridge*


```solidity
function getBridgeAddress(uint8 bridgeId_) external view override returns (address bridgeAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridgeId_`|`uint8`|is the id of a bridge|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridgeAddress_`|`address`|is the address of the form|


### getBridgeValidator

*gets the address of a bridge validator*


```solidity
function getBridgeValidator(uint8 bridgeId_) external view override returns (address bridgeValidator_);
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
function getAmbAddress(uint8 ambId_) external view override returns (address ambAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8`|is the id of a bridge|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of the form|


### getAmbId

*gets the id of the amb*


```solidity
function getAmbId(address ambAddress_) external view override returns (uint8 ambId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of an amb|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8`|is the identifier of an amb|


### getStateRegistry

*gets the address of the registry*


```solidity
function getStateRegistry(uint8 registryId_) external view override returns (address registryAddress_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`registryId_`|`uint8`|is the id of the state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`registryAddress_`|`address`|is the address of the state registry|


### getStateRegistryId

reverts if the id is not found

*gets the id of the registry*


```solidity
function getStateRegistryId(address registryAddress_) external view override returns (uint8 registryId_);
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
function getStateSyncer(uint8 superformRouterId_) external view override returns (address stateSyncer_);
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
function getRouter(uint8 superformRouterId_) external view override returns (address router_);
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
function getSuperformRouterId(address router_) external view override returns (uint8 superformRouterId_);
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
function isValidStateRegistry(address registryAddress_) external view override returns (bool valid_);
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
function isValidAmbImpl(address ambAddress_) external view override returns (bool valid_);
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
function isValidBroadcastAmbImpl(address ambAddress_) external view override returns (bool valid_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambAddress_`|`address`|is the address of the broadcast amb implementation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`valid_`|`bool`|a flag indicating if its valid.|


