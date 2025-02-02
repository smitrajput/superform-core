# ERC4626KYCDaoForm
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/forms/ERC4626KYCDaoForm.sol)

**Inherits:**
[ERC4626FormImplementation](/src/forms/ERC4626FormImplementation.sol/abstract.ERC4626FormImplementation.md)

The Form implementation for IERC4626 vaults with kycDAO NFT checks

This form must hold a kycDAO NFT to operate


## Functions
### constructor


```solidity
constructor(address superRegistry_) ERC4626FormImplementation(superRegistry_, 1);
```

### _kycCheck

*this function calls the kycDAO vault kycCheck function to verify if the beneficiary holds a kycDAO token*

*note that this form must also be a holder of a kycDAO NFT*


```solidity
function _kycCheck(address srcSender_) internal view;
```

### _directDepositIntoVault

*Deposits underlying tokens into a vault*


```solidity
function _directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
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


```solidity
function _xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
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

## Errors
### NO_VALID_KYC_TOKEN
*error thrown when the sender doesn't the KYCDAO*


```solidity
error NO_VALID_KYC_TOKEN();
```

