# BaseStateRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/BaseStateRegistry.sol)

**Inherits:**
[IBaseStateRegistry](/src/interfaces/IBaseStateRegistry.sol/interface.IBaseStateRegistry.md)

**Author:**
Zeropoint Labs

*contract module that allows inheriting contracts to implement crosschain messaging & processing mechanisms.*

*This is a lightweight version that allows only dispatching and receiving crosschain*

*payloads (messages). Inheriting children contracts have the flexibility to define their own processing
mechanisms.*


## State Variables
### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### payloadsCount

```solidity
uint256 public payloadsCount;
```


### payloadBody
*stores received payload after assigning them an unique identifier upon receiving*


```solidity
mapping(uint256 => bytes) public payloadBody;
```


### payloadHeader
*stores received payload's header (txInfo)*


```solidity
mapping(uint256 => uint256) public payloadHeader;
```


### messageQuorum
*stores a proof's quorum*


```solidity
mapping(bytes32 => uint256) public messageQuorum;
```


### payloadTracking
*maps payloads to their current status*


```solidity
mapping(uint256 => PayloadState) public payloadTracking;
```


### msgAMB
*maps payloads to the amb ids that delivered them*


```solidity
mapping(uint256 => uint8) public msgAMB;
```


### proofAMB
*maps payloads to the amb ids that delivered them*


```solidity
mapping(bytes32 => uint8[]) internal proofAMB;
```


## Functions
### onlySender

inheriting contracts should override this function (else not safe)

*sender varies based on functionality*


```solidity
modifier onlySender() virtual;
```

### constructor


```solidity
constructor(ISuperRegistry superRegistry_);
```

### receive


```solidity
receive() external payable;
```

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
    payable
    override
    onlySender;
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
function receivePayload(uint64 srcChainId_, bytes memory message_) external override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the superform chainId from which the payload is dispatched/sent|
|`message_`|`bytes`|is the crosschain payload received NOTE: Only {IMPLEMENTATION_CONTRACT} role can call this function.|


### processPayload

*proofHash will always be 32 bytes length due to keccak256*

*if message, store header and body of it*


```solidity
function processPayload(uint256 payloadId_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload NOTE: Only {CORE_STATE_REGISTRY_PROCESSOR_ROLE} role can call this function NOTE: this should handle reverting the state on source chain in-case of failure (or) can implement scenario based reverting like in coreStateRegistry|


### getProofAMB

*allows users to read the amb that delivered the proof*


```solidity
function getProofAMB(bytes32 proof_) external view override returns (uint8[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proof_`|`bytes32`|is the bytes32 proof|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint8[]`|ambIds_ is the identifier of ambs that delivered the proof|


### _getAmbId

*returns the amb id for address*


```solidity
function _getAmbId(address amb_) internal view returns (uint8 ambId);
```

### _getAmbAddress

*returns the amb id for address*


```solidity
function _getAmbAddress(uint8 id_) internal view returns (address amb);
```

### _dispatchPayload

*dispatches the payload(message_) through individual message bridge implementations*


```solidity
function _dispatchPayload(
    address srcSender_,
    uint8 ambId_,
    uint64 dstChainId_,
    uint256 gasToPay_,
    bytes memory message_,
    bytes memory overrideData_
)
    internal;
```

### _dispatchProof

*revert if an unknown amb id is used*

*dispatches the proof(hash of the message_) through individual message bridge implementations*


```solidity
function _dispatchProof(
    address srcSender_,
    uint8[] memory ambIds_,
    uint64 dstChainId_,
    uint256[] memory gasToPay_,
    bytes memory message_,
    bytes[] memory overrideData_
)
    internal;
```

