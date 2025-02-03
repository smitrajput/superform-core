# BroadCastAMBExtraData
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*struct that contains the data on the fees to pay to the AMBs on broadcasts*


```solidity
struct BroadCastAMBExtraData {
    uint256[] gasPerDst;
    bytes[] extraDataPerDst;
}
```

