# IERC4626Form
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/forms/interfaces/IERC4626Form.sol)

**Inherits:**
IERC20

**Author:**
Zeropoint Labs

SPDX-License-Identifier: Apache-2.0


## Functions
### vaultSharesIsERC20


```solidity
function vaultSharesIsERC20() external pure returns (bool);
```

### vaultSharesIsERC4626


```solidity
function vaultSharesIsERC4626() external pure returns (bool);
```

### getVaultAsset


```solidity
function getVaultAsset() external view returns (address);
```

### getVaultName


```solidity
function getVaultName() external view returns (string memory);
```

### getVaultSymbol


```solidity
function getVaultSymbol() external view returns (string memory);
```

### getVaultDecimals


```solidity
function getVaultDecimals() external view returns (uint256);
```

### getPricePerVaultShare


```solidity
function getPricePerVaultShare() external view returns (uint256);
```

### getVaultShareBalance


```solidity
function getVaultShareBalance() external view returns (uint256);
```

### getTotalAssets


```solidity
function getTotalAssets() external view returns (uint256);
```

### getPreviewPricePerVaultShare


```solidity
function getPreviewPricePerVaultShare() external view returns (uint256);
```

### previewDepositTo


```solidity
function previewDepositTo(uint256 assets_) external view returns (uint256);
```

### previewWithdrawFrom


```solidity
function previewWithdrawFrom(uint256 assets_) external view returns (uint256);
```

### previewRedeemFrom


```solidity
function previewRedeemFrom(uint256 shares_) external view returns (uint256);
```

