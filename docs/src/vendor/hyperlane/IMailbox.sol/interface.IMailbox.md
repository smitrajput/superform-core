# IMailbox
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/hyperlane/IMailbox.sol)

*is imported from
(https://github.com/hyperlane-xyz/hyperlane-monorepo/blob/main/solidity/contracts/interfaces/IMailbox.sol)*


## Functions
### localDomain


```solidity
function localDomain() external view returns (uint32);
```

### delivered


```solidity
function delivered(bytes32 messageId) external view returns (bool);
```

### dispatch


```solidity
function dispatch(
    uint32 _destinationDomain,
    bytes32 _recipientAddress,
    bytes calldata _messageBody
)
    external
    returns (bytes32);
```

### process


```solidity
function process(bytes calldata _metadata, bytes calldata _message) external;
```

### count


```solidity
function count() external view returns (uint32);
```

### root


```solidity
function root() external view returns (bytes32);
```

### latestCheckpoint


```solidity
function latestCheckpoint() external view returns (bytes32, uint32);
```

## Events
### Dispatch
Emitted when a new message is dispatched via Hyperlane


```solidity
event Dispatch(address indexed sender, uint32 indexed destination, bytes32 indexed recipient, bytes message);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`sender`|`address`|The address that dispatched the message|
|`destination`|`uint32`|The destination domain of the message|
|`recipient`|`bytes32`|The message recipient address on `destination`|
|`message`|`bytes`|Raw bytes of message|

### DispatchId
Emitted when a new message is dispatched via Hyperlane


```solidity
event DispatchId(bytes32 indexed messageId);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`messageId`|`bytes32`|The unique message identifier|

### ProcessId
Emitted when a Hyperlane message is processed


```solidity
event ProcessId(bytes32 indexed messageId);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`messageId`|`bytes32`|The unique message identifier|

### Process
Emitted when a Hyperlane message is delivered


```solidity
event Process(uint32 indexed origin, bytes32 indexed sender, address indexed recipient);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`origin`|`uint32`|The origin domain of the message|
|`sender`|`bytes32`|The message sender address on `origin`|
|`recipient`|`address`|The address that handled the message|

