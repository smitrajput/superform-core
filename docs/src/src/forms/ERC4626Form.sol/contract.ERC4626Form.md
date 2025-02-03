# ERC4626Form
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/forms/ERC4626Form.sol)

**Inherits:**
[ERC4626FormImplementation](/src/forms/ERC4626FormImplementation.sol/abstract.ERC4626FormImplementation.md)

The Form implementation for IERC4626 vaults


## Functions
### constructor


```solidity
constructor(address superRegistry_) ERC4626FormImplementation(superRegistry_, 1);
```

### _directDepositIntoVault

*Deposits underlying tokens into a vault*


```solidity
function _directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address
)
    internal
    override
    returns (uint256 dstAmount);
```

### _directWithdrawFromVault

*Withdraws underlying tokens from a vault*


```solidity
function _directWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    internal
    override
    returns (uint256 dstAmount);
```

### _xChainDepositIntoVault

*Deposits underlying tokens into a vault*


```solidity
function _xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address,
    uint64 srcChainId_
)
    internal
    override
    returns (uint256 dstAmount);
```

### _xChainWithdrawFromVault

*Withdraws underlying tokens from a vault*


```solidity
function _xChainWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    override
    returns (uint256 dstAmount);
```

### _emergencyWithdraw

*withdraws vault shares from form during emergency*


```solidity
function _emergencyWithdraw(address refundAddress_, uint256 amount_) internal override;
```

