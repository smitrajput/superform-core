# ISuperRBAC
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/ISuperRBAC.sol)

**Inherits:**
IAccessControl

**Author:**
Zeropoint Labs.

*interface for Super RBAC*


## Functions
### setSuperRegistry

*updates the super registry address*


```solidity
function setSuperRegistry(address superRegistry_) external;
```

### setRoleAdmin

*configures a new role in superForm*


```solidity
function setRoleAdmin(bytes32 role_, bytes32 adminRole_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`role_`|`bytes32`|the role to set|
|`adminRole_`|`bytes32`|the admin role to set as admin|


### revokeRoleSuperBroadcast

*revokes the role_ from superRegistryAddressId_ on all chains*


```solidity
function revokeRoleSuperBroadcast(
    bytes32 role_,
    address addressToRevoke_,
    bytes memory extraData_,
    bytes32 superRegistryAddressId_
)
    external
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`role_`|`bytes32`|the role to revoke|
|`addressToRevoke_`|`address`|the address to revoke the role from|
|`extraData_`|`bytes`|amb config if broadcasting is required|
|`superRegistryAddressId_`|`bytes32`|the super registry address id|


### stateSyncBroadcast

may not work for all roles

*allows sync of global roles from different chains using broadcast registry*


```solidity
function stateSyncBroadcast(bytes memory data_) external;
```

### PROTOCOL_ADMIN_ROLE

*returns the id of the protocol admin role*


```solidity
function PROTOCOL_ADMIN_ROLE() external view returns (bytes32);
```

### EMERGENCY_ADMIN_ROLE

*returns the id of the emergency admin role*


```solidity
function EMERGENCY_ADMIN_ROLE() external view returns (bytes32);
```

### PAYMENT_ADMIN_ROLE

*returns the id of the payment admin role*


```solidity
function PAYMENT_ADMIN_ROLE() external view returns (bytes32);
```

### BROADCASTER_ROLE

*returns the id of the broadcaster role*


```solidity
function BROADCASTER_ROLE() external view returns (bytes32);
```

### CORE_STATE_REGISTRY_PROCESSOR_ROLE

*returns the id of the core state registry processor role*


```solidity
function CORE_STATE_REGISTRY_PROCESSOR_ROLE() external view returns (bytes32);
```

### CORE_STATE_REGISTRY_RESCUER_ROLE

*returns the id of the core state registry rescuer role*


```solidity
function CORE_STATE_REGISTRY_RESCUER_ROLE() external view returns (bytes32);
```

### CORE_STATE_REGISTRY_DISPUTER_ROLE

*returns the id of the core state registry rescue disputer role*


```solidity
function CORE_STATE_REGISTRY_DISPUTER_ROLE() external view returns (bytes32);
```

### TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE

*returns the id of the two steps state registry processor role*


```solidity
function TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE() external view returns (bytes32);
```

### BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE

*returns the id of the broadcast state registry processor role*


```solidity
function BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE() external view returns (bytes32);
```

### DST_SWAPPER_ROLE

*returns the id of the dst swapper role*


```solidity
function DST_SWAPPER_ROLE() external view returns (bytes32);
```

### CORE_STATE_REGISTRY_UPDATER_ROLE

*returns the id of the core state registry updater role*


```solidity
function CORE_STATE_REGISTRY_UPDATER_ROLE() external view returns (bytes32);
```

### WORMHOLE_VAA_RELAYER_ROLE

*returns the id of wormhole vaa relayer role*


```solidity
function WORMHOLE_VAA_RELAYER_ROLE() external view returns (bytes32);
```

### hasProtocolAdminRole

*returns whether the given address has the protocol admin role*


```solidity
function hasProtocolAdminRole(address admin_) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`admin_`|`address`|the address to check|


### hasEmergencyAdminRole

*returns whether the given address has the emergency admin role*


```solidity
function hasEmergencyAdminRole(address admin_) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`admin_`|`address`|the address to check|


## Structs
### InitialRoleSetup

```solidity
struct InitialRoleSetup {
    address admin;
    address emergencyAdmin;
    address paymentAdmin;
    address csrProcessor;
    address tlProcessor;
    address brProcessor;
    address csrUpdater;
    address srcVaaRelayer;
    address dstSwapper;
    address csrRescuer;
    address csrDisputer;
}
```

