# IBridgeValidator
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBridgeValidator.sol)

**Author:**
Zeropoint Labs


## Functions
### validateLiqDstChainId

*validates the destination chainId of the liquidity request*


```solidity
function validateLiqDstChainId(bytes calldata txData_, uint64 liqDstChainId_) external pure returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txData_`|`bytes`|the txData of the deposit|
|`liqDstChainId_`|`uint64`|the chainId of the destination chain for liquidity|


### validateReceiver

*decoded txData and returns the receiver address*


```solidity
function validateReceiver(bytes calldata txData_, address receiver_) external pure returns (bool valid_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txData_`|`bytes`|is the txData of the cross chain deposit|
|`receiver_`|`address`|is the address of the receiver to validate|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`valid_`|`bool`|if the address is valid|


### validateTxData

*validates the txData of a cross chain deposit*


```solidity
function validateTxData(ValidateTxDataArgs calldata args_) external view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`args_`|`ValidateTxDataArgs`|the txData arguments to validate in txData|


### decodeMinAmountOut

*decodes the txData and returns the minimum amount expected to receive on the destination*


```solidity
function decodeMinAmountOut(
    bytes calldata txData_,
    bool genericSwapDisallowed_
)
    external
    view
    returns (uint256 amount_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txData_`|`bytes`|is the txData of the cross chain deposit|
|`genericSwapDisallowed_`|`bool`|true if generic swaps are disallowed|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`amount_`|`uint256`|the amount expected|


### decodeAmountIn

*decodes the txData and returns the amount of external token on source*


```solidity
function decodeAmountIn(bytes calldata txData_, bool genericSwapDisallowed_) external view returns (uint256 amount_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txData_`|`bytes`|is the txData of the cross chain deposit|
|`genericSwapDisallowed_`|`bool`|true if generic swaps are disallowed|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`amount_`|`uint256`|the amount expected|


### decodeDstSwap

*decodes the amount in from the txData that just involves a swap*


```solidity
function decodeDstSwap(bytes calldata txData_) external pure returns (address token_, uint256 amount_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txData_`|`bytes`|is the txData to be decoded|


## Structs
### ValidateTxDataArgs

```solidity
struct ValidateTxDataArgs {
    bytes txData;
    uint64 srcChainId;
    uint64 dstChainId;
    uint64 liqDstChainId;
    bool deposit;
    address superform;
    address srcSender;
    address liqDataToken;
}
```

