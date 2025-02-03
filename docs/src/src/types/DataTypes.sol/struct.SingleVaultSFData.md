# SingleVaultSFData
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

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

