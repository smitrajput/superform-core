# ILiFi
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/lifi/ILiFi.sol)

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

