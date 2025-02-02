# LiqRequest
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/LiquidityTypes.sol)

*contains all the common struct used for interchain token transfers.*


```solidity
struct LiqRequest {
    uint8 bridgeId;
    bytes txData;
    address token;
    uint64 liqDstChainId;
    uint256 nativeAmount;
}
```

