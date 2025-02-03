# InitMultiVaultData
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*struct for SuperRouter with re-arranged data for the message (contains the payloadId)*


```solidity
struct InitMultiVaultData {
    uint8 superformRouterId;
    uint256 payloadId;
    uint256[] superformIds;
    uint256[] amounts;
    uint256[] maxSlippage;
    bool[] hasDstSwaps;
    LiqRequest[] liqData;
    address dstRefundAddress;
    bytes extraFormData;
}
```

