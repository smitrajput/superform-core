# ILiFi
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/lifi/ILiFi.sol)

Interface containing useful structs when using LiFi as a bridge

taken from LiFi contracts https://github.com/lifinance/contracts


## Structs
### BridgeData

```solidity
struct BridgeData {
    bytes32 transactionId;
    string bridge;
    string integrator;
    address referrer;
    address sendingAssetId;
    address receiver;
    uint256 minAmount;
    uint256 destinationChainId;
    bool hasSourceSwaps;
    bool hasDestinationCall;
}
```

