# SingleVaultSFData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*main struct that holds required single vault data for an action*


```solidity
struct SingleVaultSFData {
    uint256 superformId;
    uint256 amount;
    uint256 maxSlippage;
    bool hasDstSwap;
    LiqRequest liqRequest;
    bytes permit2data;
    address dstRefundAddress;
    bytes extraFormData;
}
```

