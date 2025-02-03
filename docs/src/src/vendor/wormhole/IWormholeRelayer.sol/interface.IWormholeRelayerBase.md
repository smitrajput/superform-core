# IWormholeRelayerBase
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/wormhole/IWormholeRelayer.sol)


## Functions
### getRegisteredWormholeRelayerContract


```solidity
function getRegisteredWormholeRelayerContract(uint16 chainId) external view returns (bytes32);
```

## Events
### SendEvent

```solidity
event SendEvent(uint64 indexed sequence, uint256 deliveryQuote, uint256 paymentForExtraReceiverValue);
```

