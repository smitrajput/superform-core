# TimelockPayload
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

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

