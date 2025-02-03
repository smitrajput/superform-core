# IMessageRecipient
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/hyperlane/IMessageRecipient.sol)

*is imported from
(https://github.com/hyperlane-xyz/hyperlane-monorepo/blob/main/solidity/contracts/interfaces/IMessageRecipient.sol)*


## Functions
### handle


```solidity
function handle(uint32 _origin, bytes32 _sender, bytes calldata _message) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_origin`|`uint32`|Domain ID of the chain from which the message came|
|`_sender`|`bytes32`|Address of the message sender on the origin chain as bytes32|
|`_message`|`bytes`|Raw bytes content of message body|


