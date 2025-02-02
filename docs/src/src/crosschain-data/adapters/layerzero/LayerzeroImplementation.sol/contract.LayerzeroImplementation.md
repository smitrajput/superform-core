# LayerzeroImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/adapters/layerzero/LayerzeroImplementation.sol)

**Inherits:**
[IAmbImplementation](/src/interfaces/IAmbImplementation.sol/interface.IAmbImplementation.md), [ILayerZeroUserApplicationConfig](/src/vendor/layerzero/ILayerZeroUserApplicationConfig.sol/interface.ILayerZeroUserApplicationConfig.md), [ILayerZeroReceiver](/src/vendor/layerzero/ILayerZeroReceiver.sol/interface.ILayerZeroReceiver.md)

**Author:**
Zeropoint Labs

*allows state registries to use Layerzero for crosschain communication*


## State Variables
### RECEIVER_OFFSET

```solidity
uint256 private constant RECEIVER_OFFSET = 1;
```


### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### lzEndpoint

```solidity
ILayerZeroEndpoint public lzEndpoint;
```


### isValid
*prevents layerzero relayer from replaying payload*


```solidity
mapping(uint16 => mapping(uint64 => bool)) public isValid;
```


### ambChainId

```solidity
mapping(uint64 => uint16) public ambChainId;
```


### superChainId

```solidity
mapping(uint16 => uint64) public superChainId;
```


### trustedRemoteLookup

```solidity
mapping(uint16 => bytes) public trustedRemoteLookup;
```


### failedMessages

```solidity
mapping(uint16 => mapping(bytes => mapping(uint64 => bytes32))) public failedMessages;
```


## Functions
### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### constructor


```solidity
constructor(ISuperRegistry superRegistry_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`ISuperRegistry`|is the super registry address|


### dispatchPayload

*allows state registry to send message via implementation.*


```solidity
function dispatchPayload(
    address srcSender_,
    uint64 dstChainId_,
    bytes memory message_,
    bytes memory extraData_
)
    external
    payable
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the caller (used for gas refunds)|
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message to be sent|
|`extraData_`|`bytes`|is message amb specific override information|


### setChainId

*allows protocol admin to add new chain ids in future*


```solidity
function setChainId(uint64 superChainId_, uint16 ambChainId_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superChainId_`|`uint64`|is the identifier of the chain within superform protocol|
|`ambChainId_`|`uint16`|is the identifier of the chain given by the AMB NOTE: cannot be defined in an interface as types vary for each message bridge (amb)|


### _nonblockingLzReceive

*reset old mappings*


```solidity
function _nonblockingLzReceive(uint16 _srcChainId, bytes memory, bytes memory _payload) internal;
```

### lzReceive

*decodes payload received
NOTE: experimental split of registry contracts*


```solidity
function lzReceive(
    uint16 srcChainId_,
    bytes memory srcAddress_,
    uint64 nonce_,
    bytes memory payload_
)
    public
    override;
```

### nonblockingLzReceive


```solidity
function nonblockingLzReceive(uint16 srcChainId_, bytes memory srcAddress_, bytes memory payload_) public;
```

### retryMessage


```solidity
function retryMessage(
    uint16 srcChainId_,
    bytes memory srcAddress_,
    uint64 nonce_,
    bytes memory payload_
)
    public
    payable;
```

### _lzSend


```solidity
function _lzSend(
    uint16 dstChainId_,
    bytes memory payload_,
    address payable refundAddress_,
    address zroPaymentAddress_,
    bytes memory adapterParams_,
    uint256 msgValue_
)
    internal;
```

### _blockingLzReceive


```solidity
function _blockingLzReceive(
    uint16 srcChainId_,
    bytes memory srcAddress_,
    uint64 nonce_,
    bytes memory payload_
)
    internal;
```

### setLzEndpoint

*allows protocol admin to configure layerzero endpoint*


```solidity
function setLzEndpoint(address endpoint_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`endpoint_`|`address`|is the layerzero endpoint on the deployed network|


### getConfig


```solidity
function getConfig(
    uint16 version_,
    uint16 chainId_,
    address,
    uint256 configType_
)
    external
    view
    returns (bytes memory);
```

### setConfig

*allows protocol admin to configure UA on layerzero*


```solidity
function setConfig(
    uint16 version_,
    uint16 chainId_,
    uint256 configType_,
    bytes calldata config_
)
    external
    override
    onlyProtocolAdmin;
```

### setSendVersion


```solidity
function setSendVersion(uint16 version_) external override onlyProtocolAdmin;
```

### setReceiveVersion


```solidity
function setReceiveVersion(uint16 version_) external override onlyProtocolAdmin;
```

### forceResumeReceive


```solidity
function forceResumeReceive(uint16 srcChainId_, bytes calldata srcAddress_) external override onlyProtocolAdmin;
```

### setTrustedRemote


```solidity
function setTrustedRemote(uint16 srcChainId_, bytes calldata srcAddress_) external onlyProtocolAdmin;
```

### isTrustedRemote


```solidity
function isTrustedRemote(uint16 srcChainId_, bytes calldata srcAddress_) external view returns (bool);
```

### estimateFees

not all AMBs will have on-chain estimation for which this function will return 0

*returns the gas fees estimation in native tokens*


```solidity
function estimateFees(
    uint64 dstChainId_,
    bytes memory message_,
    bytes memory extraData_
)
    external
    view
    override
    returns (uint256 fees);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message|
|`extraData_`|`bytes`|is any amb-specific information|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`fees`|`uint256`|is the native_tokens to be sent along the transaction|


## Events
### EndpointUpdated

```solidity
event EndpointUpdated(address oldEndpoint_, address newEndpoint_);
```

### MessageFailed

```solidity
event MessageFailed(uint16 srcChainId_, bytes srcAddress_, uint64 nonce_, bytes payload_);
```

### SetTrustedRemote

```solidity
event SetTrustedRemote(uint16 srcChainId_, bytes srcAddress_);
```

