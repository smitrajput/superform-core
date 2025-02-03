# IPayMaster
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/IPayMaster.sol)

**Author:**
ZeroPoint Labs

*contract for destination transaction costs payment*


## Functions
### withdrawTo

*withdraws funds from pay master to target id from superRegistry*


```solidity
function withdrawTo(bytes32 superRegistryId_, uint256 nativeAmount_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistryId_`|`bytes32`|is the id of the target address in superRegistry|
|`nativeAmount_`|`uint256`|is the amount to withdraw from pay master|


### rebalanceTo

*withdraws fund from pay master to target id from superRegistry*


```solidity
function rebalanceTo(bytes32 superRegistryId_, LiqRequest memory req_, uint64 dstChainId_) external;
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
function makePayment(address user_) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`user_`|`address`|is the wallet address of the paying user|


## Events
### Payment
*is emitted when a new payment is made*


```solidity
event Payment(address indexed user, uint256 amount);
```

### PaymentWithdrawn
*is emitted when payments are moved out of collector*


```solidity
event PaymentWithdrawn(address indexed receiver, uint256 amount);
```

