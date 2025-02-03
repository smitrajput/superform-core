# QuorumManager
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-data/utils/QuorumManager.sol)

**Inherits:**
[IQuorumManager](/src/interfaces/IQuorumManager.sol/interface.IQuorumManager.md)

**Author:**
ZeroPoint Labs

*separates quorum management concerns into an abstract contract. Can be re-used (currently used by
superRegistry) to set different quorums per amb in different areas of the protocol*


## State Variables
### requiredQuorum

```solidity
mapping(uint64 srcChainId => uint256 quorum) internal requiredQuorum;
```


## Functions
### setRequiredMessagingQuorum

quorum is the number of extra ambs a message proof must go through and be validated

*allows inheriting contracts to set the messaging quorum for a specific sender chain*


```solidity
function setRequiredMessagingQuorum(uint64 srcChainId_, uint256 quorum_) external virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the chain id from which the message (payload) is sent|
|`quorum_`|`uint256`|the minimum number of message bridges required for processing NOTE: overriding child contracts should handle the sender validation & setting of message quorum|


### getRequiredMessagingQuorum

*returns the required quorum for the srcChain & dstChain*


```solidity
function getRequiredMessagingQuorum(uint64 srcChainId_) public view returns (uint256 quorum_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcChainId_`|`uint64`|is the chain id from which the message (payload) is sent|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`quorum_`|`uint256`|the minimum number of message bridges required for processing|


