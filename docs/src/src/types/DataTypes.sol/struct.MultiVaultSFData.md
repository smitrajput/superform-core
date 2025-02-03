# MultiVaultSFData
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*main struct that holds required multi vault data for an action*


```solidity
struct MultiVaultSFData {
    uint256[] superformIds;
    uint256[] amounts;
    uint256[] maxSlippages;
    bool[] hasDstSwaps;
    LiqRequest[] liqRequests;
    bytes permit2data;
    address dstRefundAddress;
    bytes extraFormData;
}
```

