# LiqRequest
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/LiquidityTypes.sol)

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

