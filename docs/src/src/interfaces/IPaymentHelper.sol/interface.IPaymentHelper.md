# IPaymentHelper
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/IPaymentHelper.sol)

**Author:**
ZeroPoint Labs

*helps decoding the bytes payload and returns meaningful information*


## Functions
### addChain

*admin config destination chain config for estimation*


```solidity
function addChain(uint64 chainId_, PaymentHelperConfig calldata config_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the identifier of new chain id|
|`config_`|`PaymentHelperConfig`|is the chain config|


### updateChainConfig

*admin update remote chain config for estimation*


```solidity
function updateChainConfig(uint64 chainId_, uint256 configType_, bytes memory config_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the remote chain's identifier|
|`configType_`|`uint256`|is the type of config from 1 -> 6|
|`config_`|`bytes`|is the encoded new configuration|


### calculateAMBData

*returns the amb overrides & gas to be used*


```solidity
function calculateAMBData(
    uint64 dstChainId_,
    uint8[] calldata ambIds_,
    bytes memory message_
)
    external
    view
    returns (uint256 totalFees, bytes memory extraData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dstChainId_`|`uint64`|is the unique dst chain identifier|
|`ambIds_`|`uint8[]`|is the identifiers of arbitrary message bridges to be used|
|`message_`|`bytes`|is the encoded cross-chain payload|


### estimateAMBFees

*returns the gas fees estimation in native tokens if we send message through a combination of AMBs*


```solidity
function estimateAMBFees(
    uint8[] memory ambIds_,
    uint64 dstChainId_,
    bytes memory message_,
    bytes[] memory extraData_
)
    external
    view
    returns (uint256 ambFees, uint256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambIds_`|`uint8[]`|is the identifier of different AMBs|
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message|
|`extraData_`|`bytes[]`|is any amb-specific information|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ambFees`|`uint256`|is the native_tokens to be sent along the transaction for all the ambIds_ included|
|`<none>`|`uint256[]`||


### estimateMultiDstMultiVault

*estimates the gas fees for multiple destination and multi vault operation*


```solidity
function estimateMultiDstMultiVault(
    MultiDstMultiVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateMultiDstSingleVault

*estimates the gas fees for multiple destination and single vault operation*


```solidity
function estimateMultiDstSingleVault(
    MultiDstSingleVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleXChainMultiVault

*estimates the gas fees for single destination and multi vault operation*


```solidity
function estimateSingleXChainMultiVault(
    SingleXChainMultiVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter    ///|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleXChainSingleVault

*estimates the gas fees for single destination and single vault operation*


```solidity
function estimateSingleXChainSingleVault(
    SingleXChainSingleVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleDirectSingleVault

*estimates the gas fees for same chain operation*


```solidity
function estimateSingleDirectSingleVault(
    SingleDirectSingleVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleDirectMultiVault

*estimates the gas fees for multiple same chain operation*


```solidity
function estimateSingleDirectMultiVault(
    SingleDirectMultiVaultStateReq calldata req_,
    bool isDeposit
)
    external
    view
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


## Events
### ChainConfigUpdated

```solidity
event ChainConfigUpdated(uint64 chainId_, uint256 configType_, bytes config_);
```

## Structs
### PaymentHelperConfig

```solidity
struct PaymentHelperConfig {
    address nativeFeedOracle;
    address gasPriceOracle;
    uint256 updateGasUsed;
    uint256 depositGasUsed;
    uint256 withdrawGasUsed;
    uint256 defaultNativePrice;
    uint256 defaultGasPrice;
    uint256 dstGasPerKB;
    uint256 ackGasCost;
    uint256 twoStepCost;
    uint256 swapGasUsed;
}
```

**Properties**

|Name|Type|Description|
|----|----|-----------|
|`nativeFeedOracle`|`address`||
|`gasPriceOracle`|`address`||
|`updateGasUsed`|`uint256`||
|`depositGasUsed`|`uint256`||
|`withdrawGasUsed`|`uint256`||
|`defaultNativePrice`|`uint256`||
|`defaultGasPrice`|`uint256`||
|`dstGasPerKB`|`uint256`||
|`ackGasCost`|`uint256`||
|`twoStepCost`|`uint256`||
|`swapGasUsed`|`uint256`||

