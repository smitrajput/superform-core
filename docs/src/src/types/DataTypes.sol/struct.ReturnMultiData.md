# ReturnMultiData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*struct that contains info on returned data from destination*


```solidity
struct ReturnMultiData {
    uint8 superformRouterId;
    uint256 payloadId;
    uint256[] superformIds;
    uint256[] amounts;
}
```

