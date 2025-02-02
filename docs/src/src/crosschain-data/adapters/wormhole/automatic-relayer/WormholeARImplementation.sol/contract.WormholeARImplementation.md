# WormholeARImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/adapters/wormhole/automatic-relayer/WormholeARImplementation.sol)

**Inherits:**
[IAmbImplementation](/src/interfaces/IAmbImplementation.sol/interface.IAmbImplementation.md), [IWormholeReceiver](/src/vendor/wormhole/IWormholeReceiver.sol/interface.IWormholeReceiver.md)

**Author:**
Zeropoint Labs

allows state registries to use wormhole for crosschain communication

*uses automatic relayers of wormhole for 1:1 messaging*


## State Variables
### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### relayer

```solidity
IWormholeRelayer public relayer;
```


### ambChainId

```solidity
mapping(uint64 => uint16) public ambChainId;
```


### superChainId

```solidity
mapping(uint16 => uint64) public superChainId;
```


### authorizedImpl

```solidity
mapping(uint16 => address) public authorizedImpl;
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


### setWormholeRelayer

*allows protocol admin to configure wormhole relayer contract*


```solidity
function setWormholeRelayer(address relayer_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`relayer_`|`address`|is the automatic relayer address for respective chain|


### dispatchPayload

*allows state registry to send message via implementation.*


```solidity
function dispatchPayload(
    address,
    uint64 dstChainId_,
    bytes memory message_,
    bytes memory extraData_
)
    external
    payable
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`||
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message to be sent|
|`extraData_`|`bytes`|is message amb specific override information|


### receiveWormholeMessages

When a `send` is performed with this contract as the target, this function will be
invoked by the WormholeRelayer contract
NOTE: This function should be restricted such that only the Wormhole Relayer contract can call it.
We also recommend that this function:
- Stores all received `deliveryHash`s in a mapping `(bytes32 => bool)`, and
on every call, checks that deliveryHash has not already been stored in the
map (This is to prevent other users maliciously trying to relay the same message)
- Checks that `sourceChain` and `sourceAddress` are indeed who
you expect to have requested the calling of `send` on the source chain
The invocation of this function corresponding to the `send` request will have msg.value equal
to the receiverValue specified in the send request.
If the invocation of this function reverts or exceeds the gas limit
specified by the send requester, this delivery will result in a `ReceiverFailure`.


```solidity
function receiveWormholeMessages(
    bytes memory payload_,
    bytes[] memory,
    bytes32 sourceAddress_,
    uint16 sourceChain_,
    bytes32 deliveryHash_
)
    public
    payable
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payload_`|`bytes`||
|`<none>`|`bytes[]`||
|`sourceAddress_`|`bytes32`||
|`sourceChain_`|`uint16`||
|`deliveryHash_`|`bytes32`||


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


### setReceiver

*reset old mappings*

*allows protocol admin to set receiver implmentation on a new chain id*


```solidity
function setReceiver(uint16 chainId_, address authorizedImpl_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint16`|is the identifier of the destination chain within wormhole|
|`authorizedImpl_`|`address`|is the implementation of the wormhole message bridge on the specified destination NOTE: cannot be defined in an interface as types vary for each message bridge (amb)|


### estimateFees

not all AMBs will have on-chain estimation for which this function will return 0

*returns the gas fees estimation in native tokens*


```solidity
function estimateFees(
    uint64 dstChainId_,
    bytes memory,
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
|`<none>`|`bytes`||
|`extraData_`|`bytes`|is any amb-specific information|

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


