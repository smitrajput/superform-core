# TimelockStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/extensions/TimelockStateRegistry.sol)

**Inherits:**
[BaseStateRegistry](/src/crosschain-data/BaseStateRegistry.sol/abstract.BaseStateRegistry.md), [ITimelockStateRegistry](/src/interfaces/ITimelockStateRegistry.sol/interface.ITimelockStateRegistry.md), ReentrancyGuard

**Author:**
Zeropoint Labs

handles communication in two stepped forms


## State Variables
### WITHDRAW_COOLDOWN_PERIOD

```solidity
bytes32 immutable WITHDRAW_COOLDOWN_PERIOD = keccak256(abi.encodeWithSignature("WITHDRAW_COOLDOWN_PERIOD()"));
```


### timelockPayloadCounter
*tracks the total time lock payloads*


```solidity
uint256 public timelockPayloadCounter;
```


### timelockPayload
*stores the timelock payloads*


```solidity
mapping(uint256 timelockPayloadId => TimelockPayload) public timelockPayload;
```


## Functions
### onlyTimelockStateRegistryProcessor


```solidity
modifier onlyTimelockStateRegistryProcessor();
```

### onlySender


```solidity
modifier onlySender() override;
```

### onlyForm

*allows only form to write to the receive paylod*


```solidity
modifier onlyForm(uint256 superformId);
```

### isValidPayloadId


```solidity
modifier isValidPayloadId(uint256 payloadId_);
```

### constructor


```solidity
constructor(ISuperRegistry superRegistry_) BaseStateRegistry(superRegistry_);
```

### receivePayload

Receives request (payload) from two steps form to process later


```solidity
function receivePayload(
    uint8 type_,
    address srcSender_,
    uint64 srcChainId_,
    uint256 lockedTill_,
    InitSingleVaultData memory data_
)
    external
    override
    onlyForm(data_.superformId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`type_`|`uint8`|is the nature of transaction (xChain: 1 or same chain: 0)|
|`srcSender_`|`address`|is the address of the source chain caller|
|`srcChainId_`|`uint64`|is the chainId of the source chain|
|`lockedTill_`|`uint256`|is the deadline for timelock (after which we can call `finalizePayload`)|
|`data_`|`InitSingleVaultData`|is the basic information of superformId, amount to withdraw of type InitSingleVaultData|


### finalizePayload

Form Keeper finalizes payload to process two steps withdraw fully


```solidity
function finalizePayload(
    uint256 timeLockPayloadId_,
    bytes memory txData_
)
    external
    payable
    override
    onlyTimelockStateRegistryProcessor
    nonReentrant;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`timeLockPayloadId_`|`uint256`||
|`txData_`|`bytes`|is the off-chain generated transaction data|


### processPayload

*set status here to prevent re-entrancy*

*this step is used to re-feed txData to avoid using old txData that would have expired by now*

*validate the incoming tx data*

*dispatch acknowledgement to mint superPositions back because of failure*

*for direct chain, superPositions are minted directly*

*restoring state for gas saving*


```solidity
function processPayload(uint256 payloadId_)
    external
    payable
    virtual
    override
    onlyTimelockStateRegistryProcessor
    isValidPayloadId(payloadId_);
```

### _getRequiredMessagingQuorum

*sets status as processed to prevent re-entrancy*

*validates quorum*

*returns the required quorum for the src chain id from super registry*


```solidity
function _getRequiredMessagingQuorum(uint64 chainId) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId`|`uint64`|is the src chain id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the quorum configured for the chain id|


### getTimelockPayload

*allows users to read the timeLockPayload_ stored per payloadId_*


```solidity
function getTimelockPayload(uint256 payloadId_) external view returns (TimelockPayload memory timelockPayload_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the unqiue payload identifier allocated on the destination chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`timelockPayload_`|`TimelockPayload`|timeLockPayload_ the timelock payload stored|


### _getDeliveryAMB

*allows users to read the ids of ambs that delivered a payload*


```solidity
function _getDeliveryAMB(uint256 payloadId_) internal view returns (uint8[] memory ambIds_);
```

### _constructSingleReturnData

CoreStateRegistry-like function for build message back to the source. In regular flow called after
xChainWithdraw succeds.

*Constructs return message in case of a FAILURE to perform redemption of already unlocked assets*


```solidity
function _constructSingleReturnData(
    address srcSender_,
    InitSingleVaultData memory singleVaultData_
)
    internal
    view
    returns (bytes memory returnMessage);
```

### _dispatchAcknowledgement

Send Data to Source to issue superform positions.

In regular flow, BaseStateRegistry function for messaging back to the source

Use constructed earlier return message to send acknowledgment (msg) back to the source


```solidity
function _dispatchAcknowledgement(uint64 dstChainId_, uint8[] memory ambIds_, bytes memory message_) internal;
```

