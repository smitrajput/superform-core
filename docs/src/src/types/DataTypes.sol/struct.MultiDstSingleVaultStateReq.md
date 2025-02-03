# MultiDstSingleVaultStateReq
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*overarching struct for multiDst requests with single vaults*


```solidity
struct MultiDstSingleVaultStateReq {
    uint8[][] ambIds;
    uint64[] dstChainIds;
    SingleVaultSFData[] superformsData;
}
```

