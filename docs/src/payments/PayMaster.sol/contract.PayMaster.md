# PayMaster
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/payments/PayMaster.sol)

**Inherits:**
[IPayMaster](/src/interfaces/IPayMaster.sol/interface.IPayMaster.md), [LiquidityHandler](/src/crosschain-liquidity/LiquidityHandler.sol/abstract.LiquidityHandler.md)

**Author:**
ZeroPoint Labs


## State Variables
### superRegistry

```solidity
ISuperRegistry public superRegistry;
```


### totalFeesPaid

```solidity
mapping(address => uint256) public totalFeesPaid;
```


## Functions
### onlyPaymentAdmin


```solidity
modifier onlyPaymentAdmin();
```

### constructor


```solidity
constructor(address superRegistry_);
```

### withdrawTo

*withdraws funds from pay master to target id from superRegistry*


```solidity
function withdrawTo(bytes32 superRegistryId_, uint256 nativeAmount_) external override onlyPaymentAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistryId_`|`bytes32`|is the id of the target address in superRegistry|
|`nativeAmount_`|`uint256`|is the amount to withdraw from pay master|


### rebalanceTo

*withdraws fund from pay master to target id from superRegistry*


```solidity
function rebalanceTo(
    bytes32 superRegistryId_,
    LiqRequest memory req_,
    uint64 dstChainId_
)
    external
    override
    onlyPaymentAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistryId_`|`bytes32`|is the id of the target address in superRegistry|
|`req_`|`LiqRequest`|is the off-chain generated liquidity request to move funds|
|`dstChainId_`|`uint64`|is the destination chain id|


### makePayment

*accepts payment from user*


```solidity
function makePayment(address user_) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`user_`|`address`|is the wallet address of the paying user|


### _withdrawNative

*helper to move native tokens same chain*


```solidity
function _withdrawNative(address receiver_, uint256 amount_) internal;
```

### _validateAndDispatchTokens

*helper to move native tokens cross-chain*


```solidity
function _validateAndDispatchTokens(LiqRequest memory liqRequest_, address receiver_) internal;
```

