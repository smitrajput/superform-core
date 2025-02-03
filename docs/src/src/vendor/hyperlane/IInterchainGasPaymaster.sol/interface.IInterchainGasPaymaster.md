# IInterchainGasPaymaster
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/hyperlane/IInterchainGasPaymaster.sol)

*is imported from
(https://github.com/hyperlane-xyz/hyperlane-monorepo/blob/main/solidity/contracts/interfaces/IInterchainGasPaymaster.sol)*


## Functions
### payForGas


```solidity
function payForGas(
    bytes32 _messageId,
    uint32 _destinationDomain,
    uint256 _gasAmount,
    address _refundAddress
)
    external
    payable;
```

### quoteGasPayment


```solidity
function quoteGasPayment(uint32 _destinationDomain, uint256 _gasAmount) external view returns (uint256);
```

## Events
### GasPayment
Emitted when a payment is made for a message's gas costs.


```solidity
event GasPayment(bytes32 indexed messageId, uint256 gasAmount, uint256 payment);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`messageId`|`bytes32`|The ID of the message to pay for.|
|`gasAmount`|`uint256`|The amount of destination gas paid for.|
|`payment`|`uint256`|The amount of native tokens paid.|

