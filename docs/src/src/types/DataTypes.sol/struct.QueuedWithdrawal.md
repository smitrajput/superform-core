# QueuedWithdrawal
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

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

