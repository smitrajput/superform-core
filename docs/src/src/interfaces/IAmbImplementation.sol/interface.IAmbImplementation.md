# IAmbImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IAmbImplementation.sol)

**Author:**
ZeroPoint Labs

*interface for arbitrary message bridge implementation*


## Functions
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
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the caller (used for gas refunds)|
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message to be sent|
|`extraData_`|`bytes`|is message amb specific override information|


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
### ChainAdded

```solidity
event ChainAdded(uint64 superChainId);
```

### AuthorizedImplAdded

```solidity
event AuthorizedImplAdded(uint64 superChainId, address authImpl);
```

