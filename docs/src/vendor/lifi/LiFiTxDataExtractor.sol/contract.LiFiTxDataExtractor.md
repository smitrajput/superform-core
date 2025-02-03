# LiFiTxDataExtractor
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/lifi/LiFiTxDataExtractor.sol)

**Author:**
LI.FI (https://li.fi)

Provides functionality for extracting calldata

upgraded to solidity 0.8.19 and adapted from CalldataVerificationFacet and LibBytes without any changes to
used functions (just stripped down functionality and renamed contract name)

taken from LiFi contracts https://github.com/lifinance/contracts

**Note:**
version: 1.1.0


## Functions
### _extractBridgeData

Extracts the bridge data from the calldata


```solidity
function _extractBridgeData(bytes calldata data) internal pure returns (ILiFi.BridgeData memory bridgeData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`bytes`|The calldata to extract the bridge data from|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridgeData`|`ILiFi.BridgeData`|The bridge data extracted from the calldata|


### _extractSwapData

Extracts the swap data from the calldata


```solidity
function _extractSwapData(bytes calldata data) internal pure returns (LibSwap.SwapData[] memory swapData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`bytes`|The calldata to extract the swap data from|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`swapData`|`LibSwap.SwapData[]`|The swap data extracted from the calldata|


### _slice


```solidity
function _slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory);
```

## Errors
### SliceOverflow

```solidity
error SliceOverflow();
```

### SliceOutOfBounds

```solidity
error SliceOutOfBounds();
```

