# AckAMBData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*acknowledgement extra data (contains gas information from dst to src callbacks)*


```solidity
struct AckAMBData {
    uint8[] ambIds;
    bytes extraData;
}
```

