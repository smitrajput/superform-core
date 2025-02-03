# WormholeSRImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/crosschain-data/adapters/wormhole/specialized-relayer/WormholeSRImplementation.sol)

**Inherits:**
[IBroadcastAmbImplementation](/src/interfaces/IBroadcastAmbImplementation.sol/interface.IBroadcastAmbImplementation.md)

**Author:**
Zeropoint Labs

allows broadcast state registry contracts to send messages to multiple chains

*uses multicast of wormhole for broadcasting*


## State Variables
### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### wormhole

```solidity
IWormhole public wormhole;
```


### broadcastFinality

```solidity
uint8 public broadcastFinality;
```


### ambChainId

```solidity
mapping(uint64 => uint16) public ambChainId;
```


### superChainId

```solidity
mapping(uint16 => uint64) public superChainId;
```


### processedMessages

```solidity
mapping(bytes32 => bool) public processedMessages;
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
|`superRegistry_`|`ISuperRegistry`|is super registry address for respective chain|


### setWormholeCore

*allows protocol admin to configure wormhole core contract*


```solidity
function setWormholeCore(address wormhole_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`wormhole_`|`address`|is wormhole address for respective chain|


### setFinality

*allows protocol admin to set broadcast finality*


```solidity
function setFinality(uint8 finality_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`finality_`|`uint8`|is the required finality on src chain|


### broadcastPayload

*allows state registry to send messages to multiple dst chains*


```solidity
function broadcastPayload(address, bytes memory message_, bytes memory) external payable virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`||
|`message_`|`bytes`|is the cross-chain message to be broadcasted|
|`<none>`|`bytes`||


### receiveMessage

*is wormhole's inherent fee for sending a message
batch id*


```solidity
function receiveMessage(bytes memory encodedMessage_) public;
```

### setChainId

*1. validate caller*

*2. validate src chain sender*

*3. validate message uniqueness*

*decoding payload*

*allows protocol admin to add new chain ids in future*


```solidity
function setChainId(uint64 superChainId_, uint16 ambChainId_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superChainId_`|`uint64`|is the identifier of the chain within superform protocol|
|`ambChainId_`|`uint16`|is the identifier of the chain given by the AMB NOTE: cannot be defined in an interface as types vary for each message bridge (amb)|


### estimateFees

estimation differs for different message bridges.

*reset old mappings*


```solidity
function estimateFees(bytes memory, bytes memory) external view override returns (uint256 fees);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`||
|`<none>`|`bytes`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`fees`|`uint256`|is the native_tokens to be sent along the transaction|


### _bytes32ToAddress

*casts a bytes32 string to address*


```solidity
function _bytes32ToAddress(bytes32 buf_) internal pure returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`buf_`|`bytes32`|is the bytes32 string to be casted|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|a address variable of the address passed in params|


