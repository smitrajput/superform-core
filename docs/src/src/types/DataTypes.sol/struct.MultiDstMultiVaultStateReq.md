# MultiDstMultiVaultStateReq
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*overarching struct for multiDst requests with multi vaults*


```solidity
struct MultiDstMultiVaultStateReq {
    uint8[][] ambIds;
    uint64[] dstChainIds;
    MultiVaultSFData[] superformsData;
}
```

