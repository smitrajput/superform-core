# LiquidityHandler
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/crosschain-liquidity/LiquidityHandler.sol)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*bridges tokens from Chain A -> Chain B. To be inherited by contracts that move liquidity*


## State Variables
### NATIVE

```solidity
address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
```


## Functions
### dispatchTokens

*dispatches tokens via a liquidity bridge*


```solidity
function dispatchTokens(
    address bridge_,
    bytes memory txData_,
    address token_,
    uint256 amount_,
    uint256 nativeAmount_
)
    internal
    virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`bridge_`|`address`|Bridge address to pass tokens to|
|`txData_`|`bytes`|liquidity bridge data|
|`token_`|`address`|Token caller deposits into superform|
|`amount_`|`uint256`|Amount of tokens to deposit|
|`nativeAmount_`|`uint256`|msg.value or msg.value + native tokens|


