# QueuedWithdrawal
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*struct for Emergency Queue*


```solidity
struct QueuedWithdrawal {
    address refundAddress;
    uint256 superformId;
    uint256 amount;
    uint256 srcPayloadId;
    bool isProcessed;
}
```

