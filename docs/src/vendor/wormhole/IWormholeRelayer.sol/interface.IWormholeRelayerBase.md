# IWormholeRelayerBase
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/wormhole/IWormholeRelayer.sol)


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

