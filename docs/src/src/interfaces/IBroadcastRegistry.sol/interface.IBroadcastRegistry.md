# IBroadcastRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBroadcastRegistry.sol)

**Author:**
ZeroPoint Labs

*is an helper for base state registry with broadcasting abilities.*


## Functions
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
    payable;
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
function receiveBroadcastPayload(uint64 srcChainId_, bytes memory message_) external;
```

### processPayload

*allows previlaged actors to process broadcasted payloads*


```solidity
function processPayload(uint256 payloadId_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payloadId_`|`uint256`|is the identifier of the cross-chain payload|


