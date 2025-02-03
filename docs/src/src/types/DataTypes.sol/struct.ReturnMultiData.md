# ReturnMultiData
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*struct that contains info on returned data from destination*


```solidity
struct ReturnMultiData {
    uint8 superformRouterId;
    uint256 payloadId;
    uint256[] superformIds;
    uint256[] amounts;
}
```

