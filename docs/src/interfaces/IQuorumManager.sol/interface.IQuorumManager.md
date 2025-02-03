# IQuorumManager
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IQuorumManager.sol)


## Functions
### setRequiredMessagingQuorum

quorum is the number of extra ambs a message proof must go through and be validated

*allows inheriting contracts to set the messaging quorum for a specific sender chain*


```solidity
function setRequiredMessagingQuorum(uint64 srcChainId_, uint256 quorum_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the chain id from which the message (payload) is sent|
|`quorum_`|`uint256`|the minimum number of message bridges required for processing NOTE: overriding child contracts should handle the sender validation & setting of message quorum|


### getRequiredMessagingQuorum

*returns the required quorum for the srcChain & dstChain*


```solidity
function getRequiredMessagingQuorum(uint64 srcChainId_) external view returns (uint256 quorum_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the chain id from which the message (payload) is sent|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`quorum_`|`uint256`|the minimum number of message bridges required for processing|


## Events
### QuorumSet
*emitted when a new quorum is set for a specific chain*


```solidity
event QuorumSet(uint64 indexed srcChainId, uint256 quorum);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId`|`uint64`|the chain id from which the message (payload) is sent|
|`quorum`|`uint256`|the minimum number of message bridges required for processing|

