# LiFiValidator
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/crosschain-liquidity/lifi/LiFiValidator.sol)

**Inherits:**
[BridgeValidator](/src/crosschain-liquidity/BridgeValidator.sol/abstract.BridgeValidator.md), [LiFiTxDataExtractor](/src/vendor/lifi/LiFiTxDataExtractor.sol/contract.LiFiTxDataExtractor.md)

**Author:**
Zeropoint Labs

*To assert input txData is valid*


## Functions
### constructor


```solidity
constructor(address superRegistry_) BridgeValidator(superRegistry_);
```

### validateLiqDstChainId


```solidity
function validateLiqDstChainId(bytes calldata txData_, uint64 liqDstChainId_) external pure override returns (bool);
```

### validateReceiver


```solidity
function validateReceiver(bytes calldata txData_, address receiver_) external pure override returns (bool valid_);
```

### validateTxData


```solidity
function validateTxData(ValidateTxDataArgs calldata args_) external view override;
```

### decodeMinAmountOut

*xchain actions can have bridgeData or bridgeData + swapData*

*direct actions with deposit, cannot have bridge data - goes into catch block*

*withdraw actions may have bridge data after withdrawing - goes into try block*

*withdraw actions without bridge data (just swap) - goes into catch block*

*0. Destination call validation*

*1. chainId validation*

*for deposits, liqDstChainId/toChainId will be the normal destination (where the target superform
is)*

*for withdraws, liqDstChainId/toChainId will be the desired chain to where the underlying must be
sent*

*to after vault redemption*

*2. receiver address validation*

*if cross chain deposits, then receiver address must be CoreStateRegistry (or) Dst Swapper*

*if withdraws, then receiver address must be the srcSender*

*remap of address 0 to NATIVE because of how LiFi produces txData*

*3. token validations*

*1. chainId validation*

*2. receiver address validation*

*If same chain deposits then receiver address must be the superform*

*if withdraws, then receiver address must be the srcSender*

*remap of address 0 to NATIVE because of how LiFi produces txData*

*3. token validations*


```solidity
function decodeMinAmountOut(
    bytes calldata txData_,
    bool genericSwapDisallowed_
)
    external
    view
    override
    returns (uint256 amount_);
```

### decodeAmountIn

*try is just used here to validate the txData. We need to always extract minAmount from bridge data*

*in the case of a generic swap, minAmountOut is considered to be the receivedAmount*


```solidity
function decodeAmountIn(
    bytes calldata txData_,
    bool genericSwapDisallowed_
)
    external
    view
    override
    returns (uint256 amount_);
```

### decodeDstSwap

*if there isn't a source swap, amountIn is minAmountOut from bridge data?*

*in the case of a generic swap, amountIn is the from amount*


```solidity
function decodeDstSwap(bytes calldata txData_) external pure override returns (address token_, uint256 amount_);
```

### extractMainParameters

Extracts the main parameters from the calldata


```solidity
function extractMainParameters(bytes calldata data_)
    public
    pure
    returns (
        string memory bridge,
        address sendingAssetId,
        address receiver,
        uint256 amount,
        uint256 minAmount,
        uint256 destinationChainId,
        bool hasSourceSwaps,
        bool hasDestinationCall
    );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|The calldata to extract the main parameters from|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridge`|`string`|The bridge extracted from the calldata|
|`sendingAssetId`|`address`|The sending asset id extracted from the calldata|
|`receiver`|`address`|The receiver extracted from the calldata|
|`amount`|`uint256`|The amount the calldata (which may be equal to bridge min amount)|
|`minAmount`|`uint256`|The min amount extracted from the bridgeData calldata|
|`destinationChainId`|`uint256`|The destination chain id extracted from the calldata|
|`hasSourceSwaps`|`bool`|Whether the calldata has source swaps|
|`hasDestinationCall`|`bool`|Whether the calldata has a destination call|


### extractGenericSwapParameters

Extracts the generic swap parameters from the calldata


```solidity
function extractGenericSwapParameters(bytes calldata data_)
    public
    pure
    returns (
        address sendingAssetId,
        uint256 amount,
        address receiver,
        address receivingAssetId,
        uint256 receivingAmount
    );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data_`|`bytes`|The calldata to extract the generic swap parameters from|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sendingAssetId`|`address`|The sending asset id extracted from the calldata|
|`amount`|`uint256`|The amount extracted from the calldata|
|`receiver`|`address`|The receiver extracted from the calldata|
|`receivingAssetId`|`address`|The receiving asset id extracted from the calldata|
|`receivingAmount`|`uint256`|The receiving amount extracted from the calldata|


