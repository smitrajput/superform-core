# MultiVaultSFData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

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

