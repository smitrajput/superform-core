# IBroadcastAmbImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBroadcastAmbImplementation.sol)

**Author:**
ZeroPoint Labs

*interface for arbitrary message bridge implementation the supports broadcasting*


## Functions
### broadcastPayload

*allows state registry to send messages to multiple dst chains*


```solidity
function broadcastPayload(address srcSender_, bytes memory message_, bytes memory extraData_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcSender_`|`address`|is the caller (used for gas refunds)|
|`message_`|`bytes`|is the cross-chain message to be broadcasted|
|`extraData_`|`bytes`|is optional broadcast override information|


### estimateFees

estimation differs for different message bridges.

*returns the gas fees estimation in native tokens*


```solidity
function estimateFees(bytes memory message_, bytes memory extraData_) external view returns (uint256 fees);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`message_`|`bytes`|is the cross-chain message to be broadcasted|
|`extraData_`|`bytes`| is optional broadcast override information|

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

