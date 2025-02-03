# TimelockPayload
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*holds information about the two-steps payload*


```solidity
struct TimelockPayload {
    uint8 isXChain;
    address srcSender;
    uint64 srcChainId;
    uint256 lockedTill;
    InitSingleVaultData data;
    TwoStepsStatus status;
}
```

