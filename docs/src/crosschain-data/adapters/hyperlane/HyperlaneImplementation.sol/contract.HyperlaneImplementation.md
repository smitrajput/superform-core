# HyperlaneImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/adapters/hyperlane/HyperlaneImplementation.sol)

**Inherits:**
[IAmbImplementation](/src/interfaces/IAmbImplementation.sol/interface.IAmbImplementation.md), [IMessageRecipient](/src/vendor/hyperlane/IMessageRecipient.sol/interface.IMessageRecipient.md)

**Author:**
Zeropoint Labs

*allows state registries to use hyperlane for crosschain communication*


## State Variables
### mailbox

```solidity
IMailbox public mailbox;
```


### igp

```solidity
IInterchainGasPaymaster public igp;
```


### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


### ambChainId

```solidity
mapping(uint64 => uint32) public ambChainId;
```


### superChainId

```solidity
mapping(uint32 => uint64) public superChainId;
```


### authorizedImpl

```solidity
mapping(uint32 => address) public authorizedImpl;
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

### setHyperlaneConfig

*allows protocol admin to configure hyperlane mailbox and gas paymaster*


```solidity
function setHyperlaneConfig(IMailbox mailbox_, IInterchainGasPaymaster igp_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`mailbox_`|`IMailbox`|is the address of hyperlane mailbox|
|`igp_`|`IInterchainGasPaymaster`|is the address of hyperlane gas paymaster|


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
    virtual
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
function setChainId(uint64 superChainId_, uint32 ambChainId_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superChainId_`|`uint64`|is the identifier of the chain within superform protocol|
|`ambChainId_`|`uint32`|is the identifier of the chain given by the AMB NOTE: cannot be defined in an interface as types vary for each message bridge (amb)|


### setReceiver

*reset old mappings*

*allows protocol admin to set receiver implmentation on a new chain id*


```solidity
function setReceiver(uint32 domain_, address authorizedImpl_) external onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`domain_`|`uint32`|is the identifier of the destination chain within hyperlane|
|`authorizedImpl_`|`address`|is the implementation of the hyperlane message bridge on the specified destination NOTE: cannot be defined in an interface as types vary for each message bridge (amb)|


### handle


```solidity
function handle(uint32 origin_, bytes32 sender_, bytes calldata body_) external override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`origin_`|`uint32`||
|`sender_`|`bytes32`||
|`body_`|`bytes`||


### estimateFees

not all AMBs will have on-chain estimation for which this function will return 0

*1. validate caller*

*2. validate src chain sender*

*3. validate message uniqueness*

*decoding payload
NOTE: experimental split of registry contracts*


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


### _castAddr

*casts an address to bytes32*


```solidity
function _castAddr(address addr_) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`addr_`|`address`|is the address to be casted|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|a bytes32 casted variable of the address passed in params|


## Events
### MailboxAdded

```solidity
event MailboxAdded(address _newMailbox);
```

### GasPayMasterAdded

```solidity
event GasPayMasterAdded(address _igp);
```

