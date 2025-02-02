# IBaseForm
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBaseForm.sol)

**Inherits:**
IERC165

**Author:**
ZeroPoint Labs

Interface for Base Form


## Functions
### directDepositIntoVault

*process same chain id deposits*


```solidity
function directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    external
    payable
    returns (uint256 dstAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`singleVaultData_`|`InitSingleVaultData`| A bytes representation containing all the data required to make a form action|
|`srcSender_`|`address`|The address of the sender of the transaction|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`dstAmount`|`uint256`| The amount of tokens deposited in same chain action|


### directWithdrawFromVault

*process withdrawal of collateral from a vault*


```solidity
function directWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    external
    returns (uint256 dstAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`singleVaultData_`|`InitSingleVaultData`| A bytes representation containing all the data required to make a form action|
|`srcSender_`|`address`|The address of the sender of the transaction|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`dstAmount`|`uint256`| The amount of tokens withdrawn in same chain action|


### xChainDepositIntoVault

*process same chain id deposits*

*is dstAmoutn is `0` then no further action/acknowledgement needs to be sent*


```solidity
function xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    external
    returns (uint256 dstAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`singleVaultData_`|`InitSingleVaultData`| A bytes representation containing all the data required to make a form action|
|`srcSender_`|`address`|The address of the sender of the transaction|
|`srcChainId_`|`uint64`|The chain id of the source chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`dstAmount`|`uint256`| The amount of tokens deposited in same chain action|


### xChainWithdrawFromVault

*process withdrawal of collateral from a vault*


```solidity
function xChainWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    external
    returns (uint256 dstAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`singleVaultData_`|`InitSingleVaultData`| A bytes representation containing all the data required to make a form action|
|`srcSender_`|`address`|The address of the sender of the transaction|
|`srcChainId_`|`uint64`|The chain id of the source chain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`dstAmount`|`uint256`|The amount of tokens withdrawn|


### emergencyWithdraw

*process withdrawal of shares if form is paused*


```solidity
function emergencyWithdraw(address refundAddress_, uint256 amount_) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`refundAddress_`|`address`|The address to refund the shares to|
|`amount_`|`uint256`|The amount of vault shares to refund|


### superformYieldTokenName

get Superform name of the ERC20 vault representation


```solidity
function superformYieldTokenName() external view returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The ERC20 name|


### superformYieldTokenSymbol

get Superform symbol of the ERC20 vault representation


```solidity
function superformYieldTokenSymbol() external view returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The ERC20 symbol|


### getVaultAsset

Returns the underlying token of a vault.


```solidity
function getVaultAsset() external view returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The asset being deposited into the vault used for accounting, depositing, and withdrawing|


### getVaultName

Returns the name of the vault.


```solidity
function getVaultName() external view returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The name of the vault|


### getVaultSymbol

Returns the symbol of a vault.


```solidity
function getVaultSymbol() external view returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The symbol associated with a vault|


### getVaultDecimals

Returns the number of decimals in a vault for accounting purposes


```solidity
function getVaultDecimals() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of decimals in the vault balance|


### getVaultAddress

*returns the vault address*


```solidity
function getVaultAddress() external view returns (address);
```

### getPricePerVaultShare

Returns the amount of underlying tokens each share of a vault is worth.


```solidity
function getPricePerVaultShare() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The pricePerVaultShare value|


### getVaultShareBalance

Returns the amount of vault shares owned by the form.


```solidity
function getVaultShareBalance() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The form's vault share balance|


### getTotalAssets

get the total amount of underlying managed in the ERC4626 vault


```solidity
function getTotalAssets() external view returns (uint256);
```

### getPreviewPricePerVaultShare

get the total amount of assets received if shares are actually redeemed

https://eips.ethereum.org/EIPS/eip-4626


```solidity
function getPreviewPricePerVaultShare() external view returns (uint256);
```

### getStateRegistryId

get the state registry id


```solidity
function getStateRegistryId() external view returns (uint256);
```

### previewDepositTo

*API may need to know state of funds deployed*


```solidity
function previewDepositTo(uint256 assets_) external view returns (uint256);
```

### previewWithdrawFrom

positionBalance() -> .vaultIds&destAmounts


```solidity
function previewWithdrawFrom(uint256 assets_) external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|how much of an asset + interest (accrued) is to withdraw from the Vault|


### previewRedeemFrom

*API may need to know state of funds deployed*


```solidity
function previewRedeemFrom(uint256 shares_) external view returns (uint256);
```

### formImplementationId


```solidity
function formImplementationId() external view returns (uint32);
```

## Events
### VaultAdded
*is emitted when a new vault is added by the admin.*


```solidity
event VaultAdded(uint256 id, IERC4626 vault);
```

### Processed
*is emitted when a payload is processed by the destination contract.*


```solidity
event Processed(uint64 srcChainID, uint64 dstChainId, uint256 srcPayloadId, uint256 amount, address vault);
```

### EmergencyWithdrawalProcessed
*is emitted when an emergency withdrawal is processed*


```solidity
event EmergencyWithdrawalProcessed(address refundAddress, uint256 amount);
```

