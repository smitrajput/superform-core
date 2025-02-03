# InitSingleVaultData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*struct for SuperRouter with re-arranged data for the message (contains the payloadId)*


```solidity
struct InitSingleVaultData {
    uint8 superformRouterId;
    uint256 payloadId;
    uint256 superformId;
    uint256 amount;
    uint256 maxSlippage;
    bool hasDstSwap;
    LiqRequest liqData;
    address dstRefundAddress;
    bytes extraFormData;
}
```

