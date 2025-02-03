# SuperRBAC
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/settings/SuperRBAC.sol)

**Inherits:**
[ISuperRBAC](/src/interfaces/ISuperRBAC.sol/interface.ISuperRBAC.md), AccessControlEnumerable

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*Contract to manage roles in the entire superform protocol*


## State Variables
### SYNC_REVOKE

```solidity
bytes32 public constant SYNC_REVOKE = keccak256("SYNC_REVOKE");
```


### PROTOCOL_ADMIN_ROLE
*used in many areas of the codebase to perform config operations*

*could be worth to have this changeable in case it gets compromised (but without ability to revoke itself)*

*changeable by which role?*

*single address*


```solidity
bytes32 public constant override PROTOCOL_ADMIN_ROLE = keccak256("PROTOCOL_ADMIN_ROLE");
```


### EMERGENCY_ADMIN_ROLE
*used in a few areas of the code*

*could be worth to have this changeable in case it gets compromised (but without ability to revoke itself)*

*changeable by which role?*

*single address*


```solidity
bytes32 public constant override EMERGENCY_ADMIN_ROLE = keccak256("EMERGENCY_ADMIN_ROLE");
```


### PAYMENT_ADMIN_ROLE
*used to extract funds from PayMaster*

*could be allowed to be changed*

*single address*


```solidity
bytes32 public constant override PAYMENT_ADMIN_ROLE = keccak256("PAYMENT_ADMIN_ROLE");
```


### BROADCASTER_ROLE
*used so that certain contracts can broadcast state changes to all connected remote chains*

*currently SUPERFORM_FACTORY, SUPERTRANSMUTER and SUPER_RBAC have this role. SUPER_RBAC doesn't need it*

*should NOT be allowed to be changed (maps to more than 1 address)*

*multi address (revoke broadcast should be restricted)*


```solidity
bytes32 public constant override BROADCASTER_ROLE = keccak256("BROADCASTER_ROLE");
```


### CORE_STATE_REGISTRY_PROCESSOR_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override CORE_STATE_REGISTRY_PROCESSOR_ROLE = keccak256("CORE_STATE_REGISTRY_PROCESSOR_ROLE");
```


### TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE =
    keccak256("TIMELOCK_STATE_REGISTRY_PROCESSOR_ROLE");
```


### BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE =
    keccak256("BROADCAST_STATE_REGISTRY_PROCESSOR_ROLE");
```


### CORE_STATE_REGISTRY_UPDATER_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override CORE_STATE_REGISTRY_UPDATER_ROLE = keccak256("CORE_STATE_REGISTRY_UPDATER_ROLE");
```


### CORE_STATE_REGISTRY_RESCUER_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override CORE_STATE_REGISTRY_RESCUER_ROLE = keccak256("CORE_STATE_REGISTRY_RESCUER_ROLE");
```


### CORE_STATE_REGISTRY_DISPUTER_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override CORE_STATE_REGISTRY_DISPUTER_ROLE = keccak256("CORE_STATE_REGISTRY_DISPUTER_ROLE");
```


### WORMHOLE_VAA_RELAYER_ROLE
*this is a role so that we could run multiple relayers*

*should be allowed to be changed*

*multi address (revoke broadcast should be restricted)*


```solidity
bytes32 public constant override WORMHOLE_VAA_RELAYER_ROLE = keccak256("WORMHOLE_VAA_RELAYER_ROLE");
```


### DST_SWAPPER_ROLE
*keeper role, should be allowed to be changed*

*single address*


```solidity
bytes32 public constant override DST_SWAPPER_ROLE = keccak256("DST_SWAPPER_ROLE");
```


### superRegistry

```solidity
ISuperRegistry public superRegistry;
```


## Functions
### constructor


```solidity
constructor(InitialRoleSetup memory roles);
```

### setSuperRegistry

*manually set role admin to PROTOCOL_ADMIN_ROLE on all roles*


```solidity
function setSuperRegistry(address superRegistry_) external override onlyRole(PROTOCOL_ADMIN_ROLE);
```

### setRoleAdmin

*configures a new role in superForm*


```solidity
function setRoleAdmin(bytes32 role_, bytes32 adminRole_) external override onlyRole(PROTOCOL_ADMIN_ROLE);
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
    payable
    override
    onlyRole(PROTOCOL_ADMIN_ROLE);
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

*revokeRoleSuperBroadcast cannot update the PROTOCOL_ADMIN_ROLE and EMERGENCY_ADMIN_ROLE*


```solidity
function stateSyncBroadcast(bytes memory data_) external override;
```

### hasProtocolAdminRole

*broadcasting cannot update the PROTOCOL_ADMIN_ROLE and EMERGENCY_ADMIN_ROLE*


```solidity
function hasProtocolAdminRole(address admin_) external view override returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`admin_`|`address`|the address to check|


### hasEmergencyAdminRole

*returns whether the given address has the emergency admin role*


```solidity
function hasEmergencyAdminRole(address emergencyAdmin_) external view override returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`emergencyAdmin_`|`address`||


### _revokeRole

*Overload [_revokeRole](/src/settings/SuperRBAC.sol/contract.SuperRBAC.md#_revokerole) to track enumerable memberships*


```solidity
function _revokeRole(bytes32 role_, address account_) internal override;
```

### _broadcast

*interacts with role state registry to broadcasting state changes to all connected remote chains*


```solidity
function _broadcast(bytes memory message_, bytes memory extraData_) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`message_`|`bytes`|is the crosschain message to be sent.|
|`extraData_`|`bytes`|is the amb override information.|


