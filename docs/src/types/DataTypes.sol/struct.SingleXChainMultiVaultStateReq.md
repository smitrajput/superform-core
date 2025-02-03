# SingleXChainMultiVaultStateReq
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*overarching struct for single cross chain requests with multi vaults*


```solidity
struct SingleXChainMultiVaultStateReq {
    uint8[] ambIds;
    uint64 dstChainId;
    MultiVaultSFData superformsData;
}
```

