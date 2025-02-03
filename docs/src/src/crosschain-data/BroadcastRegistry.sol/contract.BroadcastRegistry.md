# BroadcastRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/crosschain-data/BroadcastRegistry.sol)

**Inherits:**
[IBroadcastRegistry](/src/interfaces/IBroadcastRegistry.sol/interface.IBroadcastRegistry.md), [QuorumManager](/src/crosschain-data/utils/QuorumManager.sol/abstract.QuorumManager.md)

**Author:**
ZeroPoint Labs

helps core contract communicate with multiple dst chains through supported AMBs


## State Variables
### superRegistry

```solidity
ISuperRegistry public superRegistry;
```


### payloadsCount

```solidity
uint256 public payloadsCount;
```


### messageQuorum
*stores the message quorum*


```solidity
mapping(bytes32 => uint256) public messageQuorum;
```


### payload
*stores the received payload after assigning*


```solidity
mapping(uint256 => bytes) public payload;
```


### srcChainId
*stores the src chain of every payload*


```solidity
mapping(uint256 => uint64) public srcChainId;
```


### payloadTracking
*stores the status of the received payload*


```solidity
mapping(uint256 => PayloadState) public payloadTracking;
```


## Functions
### constructor

*set up admin during deployment.*


```solidity
constructor(ISuperRegistry superRegistry_);
```

### onlySender

sender should be a valid configured contract

*should be factory or roles contract*


```solidity
modifier onlySender();
```

### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### onlyProcessor


```solidity
modifier onlyProcessor();
```

### setRequiredMessagingQuorum


```solidity
function setRequiredMessagingQuorum(uint64 srcChainId_, uint256 quorum_) external override onlyProtocolAdmin;
```

### broadcastPayload

*allows core contracts to send payload to all configured destination chain.*


```solidity
function broadcastPayload(
    address srcSender_,
    uint8[] memory ambIds_,
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
|`message_`|`bytes`|is the crosschain payload to be broadcasted|
|`extraData_`|`bytes`|defines all the message bridge realted overrides|


### receiveBroadcastPayload

*allows ambs to write broadcasted payloads*


```solidity
function receiveBroadcastPayload(uint64 srcChainId_, bytes memory message_) external override;
```

### processPayload

*allows previlaged actors to process broadcasted payloads*


```solidity
function processPayload(uint256 payloadId) external override onlyProcessor;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId`|`uint256`||


### _broadcastPayload

*The number of valid proofs (quorum) must be equal to the required messaging quorum*

*broadcasts the payload(message_) through individual message bridge implementations*


```solidity
function _broadcastPayload(
    address srcSender_,
    uint8 ambId_,
    uint256 gasToPay_,
    bytes memory message_,
    bytes memory extraData_
)
    internal;
```

### _broadcastProof

*reverts if an unknown amb id is used*

*broadcasts the proof(hash of the message_) through individual message bridge implementations*


```solidity
function _broadcastProof(
    address srcSender_,
    uint8[] memory ambIds_,
    uint256[] memory gasToPay_,
    bytes memory message_,
    bytes[] memory extraData_
)
    internal;
```

