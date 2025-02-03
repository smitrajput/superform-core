# IBaseStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBaseStateRegistry.sol)

**Author:**
ZeroPoint Labs

*Is the crosschain interaction point. Send, store & process crosschain messages*


## Functions
### dispatchPayload

*allows core contracts to send payload to a destination chain.*


```solidity
function dispatchPayload(
    address srcSender_,
    uint8[] memory ambIds_,
    uint64 dstChainId_,
    bytes memory message_,
    bytes memory extraData_
)
    external
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the caller of the function (used for gas refunds).|
|`ambIds_`|`uint8[]`|is the identifier of the arbitrary message bridge to be used|
|`dstChainId_`|`uint64`|is the internal chainId used throughtout the protocol|
|`message_`|`bytes`|is the crosschain payload to be sent|
|`extraData_`|`bytes`|defines all the message bridge realted overrides NOTE: dstChainId_ is mapped to message bridge's destination id inside it's implementation contract NOTE: ambIds_ are superform assigned unique identifier for arbitrary message bridges|


### receivePayload

*allows state registry to receive messages from message bridge implementations*


```solidity
function receivePayload(uint64 srcChainId_, bytes memory message_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the superform chainId from which the payload is dispatched/sent|
|`message_`|`bytes`|is the crosschain payload received NOTE: Only {IMPLEMENTATION_CONTRACT} role can call this function.|


### processPayload

*allows previlaged actors to process cross-chain payloads*


```solidity
function processPayload(uint256 payloadId_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload NOTE: Only {CORE_STATE_REGISTRY_PROCESSOR_ROLE} role can call this function NOTE: this should handle reverting the state on source chain in-case of failure (or) can implement scenario based reverting like in coreStateRegistry|


### payloadsCount

*allows users to read the total payloads received by the registry*


```solidity
function payloadsCount() external view returns (uint256);
```

### payloadTracking

*allows user to read the payload state
uint256 payloadId_ is the unique payload identifier allocated on the destiantion chain*


```solidity
function payloadTracking(uint256 payloadId_) external view returns (PayloadState payloadState_);
```

### payloadBody

*allows users to read the bytes payload_ stored per payloadId_*


```solidity
function payloadBody(uint256 payloadId_) external view returns (bytes memory payloadBody_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the unqiue payload identifier allocated on the destination chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`payloadBody_`|`bytes`|the crosschain data received|


### payloadHeader

*allows users to read the uint256 payloadHeader stored per payloadId_*


```solidity
function payloadHeader(uint256 payloadId_) external view returns (uint256 payloadHeader_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the unqiue payload identifier allocated on the destination chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`payloadHeader_`|`uint256`|the crosschain header received|


### msgAMB

*allows users to read the amb that delivered the payload*


```solidity
function msgAMB(uint256 payloadId_) external view returns (uint8 ambId_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the unqiue payload identifier allocated on the destination chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambId_`|`uint8`|is the amb that delivered the payload|


### getProofAMB

*allows users to read the amb that delivered the proof*


```solidity
function getProofAMB(bytes32 proof_) external view returns (uint8[] memory ambIds_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proof_`|`bytes32`|is the bytes32 proof|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambIds_`|`uint8[]`|is the identifier of ambs that delivered the proof|


## Events
### PayloadReceived
*is emitted when a cross-chain payload is received in the state registry*


```solidity
event PayloadReceived(uint64 srcChainId, uint64 dstChainId, uint256 payloadId);
```

### ProofReceived
*is emitted when a cross-chain proof is received in the state registry
NOTE: comes handy if quorum required is more than 0*


```solidity
event ProofReceived(bytes proof);
```

### PayloadUpdated
*is emitted when a payload id gets updated*


```solidity
event PayloadUpdated(uint256 payloadId);
```

### PayloadProcessed
*is emitted when a payload id gets processed*


```solidity
event PayloadProcessed(uint256 payloadId);
```

### SuperRegistryUpdated
*is emitted when the super registry address is updated*


```solidity
event SuperRegistryUpdated(address indexed superRegistry);
```

