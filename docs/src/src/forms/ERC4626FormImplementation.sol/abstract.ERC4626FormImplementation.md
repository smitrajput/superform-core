# ERC4626FormImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/forms/ERC4626FormImplementation.sol)

**Inherits:**
[BaseForm](/src/BaseForm.sol/abstract.BaseForm.md), [LiquidityHandler](/src/crosschain-liquidity/LiquidityHandler.sol/abstract.LiquidityHandler.md)

Has common internal functions that can be re-used by actual form implementations


## State Variables
### STATE_REGISTRY_ID

```solidity
uint256 internal immutable STATE_REGISTRY_ID;
```


## Functions
### constructor


```solidity
constructor(address superRegistry_, uint256 stateRegistryId_) BaseForm(superRegistry_);
```

### getVaultAsset


```solidity
function getVaultAsset() public view virtual override returns (address);
```

### getVaultName


```solidity
function getVaultName() public view virtual override returns (string memory);
```

### getVaultSymbol


```solidity
function getVaultSymbol() public view virtual override returns (string memory);
```

### getVaultDecimals


```solidity
function getVaultDecimals() public view virtual override returns (uint256);
```

### getPricePerVaultShare


```solidity
function getPricePerVaultShare() public view virtual override returns (uint256);
```

### getVaultShareBalance


```solidity
function getVaultShareBalance() public view virtual override returns (uint256);
```

### getTotalAssets


```solidity
function getTotalAssets() public view virtual override returns (uint256);
```

### getPreviewPricePerVaultShare


```solidity
function getPreviewPricePerVaultShare() public view virtual override returns (uint256);
```

### previewDepositTo


```solidity
function previewDepositTo(uint256 assets_) public view virtual override returns (uint256);
```

### previewWithdrawFrom


```solidity
function previewWithdrawFrom(uint256 assets_) public view virtual override returns (uint256);
```

### previewRedeemFrom


```solidity
function previewRedeemFrom(uint256 shares_) public view virtual override returns (uint256);
```

### _processDirectDeposit


```solidity
function _processDirectDeposit(InitSingleVaultData memory singleVaultData_) internal returns (uint256 dstAmount);
```

### _processDirectWithdraw


```solidity
function _processDirectWithdraw(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    internal
    returns (uint256 dstAmount);
```

### _processXChainDeposit

*if there is no txData, on withdraws the receiver is the original beneficiary (srcSender_), otherwise it
is this contract (before swap)*

*the token we are swapping from to our desired output token (if there is txData), must be the same as
the vault asset*

*redeem the underlying*

*the amount inscribed in liqData must be less or equal than the amount redeemed from the vault*

*validate and perform the swap to desired output token and send to beneficiary*


```solidity
function _processXChainDeposit(
    InitSingleVaultData memory singleVaultData_,
    uint64 srcChainId_
)
    internal
    returns (uint256 dstAmount);
```

### _processXChainWithdraw


```solidity
function _processXChainWithdraw(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    returns (uint256 dstAmount);
```

### _processEmergencyWithdraw

*a case where the withdraw req liqData has a valid token and tx data is not updated by the keeper*

*if there is no txData, on withdraws the receiver is the original beneficiary (srcSender_), otherwise it
is this contract (before swap)*

*the token we are swapping from to our desired output token (if there is txData), must be the same as
the vault asset*

*redeem vault positions (we operate only on positions, not assets)*

*the amount inscribed in liqData must be less or equal than the amount redeemed from the vault*

*validate and perform the swap to desired output token and send to beneficiary*


```solidity
function _processEmergencyWithdraw(address refundAddress_, uint256 amount_) internal;
```

### superformYieldTokenName


```solidity
function superformYieldTokenName() external view virtual override returns (string memory);
```

### superformYieldTokenSymbol


```solidity
function superformYieldTokenSymbol() external view virtual override returns (string memory);
```

### getStateRegistryId


```solidity
function getStateRegistryId() external view override returns (uint256);
```

### _vaultSharesAmountToUnderlyingAmount

*Converts a vault share amount into an equivalent underlying asset amount*


```solidity
function _vaultSharesAmountToUnderlyingAmount(
    uint256 vaultSharesAmount_,
    uint256
)
    internal
    view
    virtual
    override
    returns (uint256);
```

### _vaultSharesAmountToUnderlyingAmountRoundingUp

*Converts a vault share amount into an equivalent underlying asset amount, rounding up*


```solidity
function _vaultSharesAmountToUnderlyingAmountRoundingUp(
    uint256 vaultSharesAmount_,
    uint256
)
    internal
    view
    virtual
    override
    returns (uint256);
```

### _underlyingAmountToVaultSharesAmount

*Converts an underlying asset amount into an equivalent vault shares amount*


```solidity
function _underlyingAmountToVaultSharesAmount(
    uint256 underlyingAmount_,
    uint256
)
    internal
    view
    virtual
    override
    returns (uint256);
```

## Structs
### directDepositLocalVars
*to avoid stack too deep errors*


```solidity
struct directDepositLocalVars {
    uint64 chainId;
    address collateral;
    address bridgeValidator;
    uint256 dstAmount;
    uint256 balanceBefore;
    uint256 balanceAfter;
    uint256 nonce;
    uint256 deadline;
    uint256 inputAmount;
    bytes signature;
}
```

### ProcessDirectWithdawLocalVars
*this is only valid if token == collateral (no txData)*

*handles the collateral token transfers.*

*transfers input token, which is the same as vault asset, to the form*

*non empty txData means there is a swap needed before depositing (input asset not the same as vault
asset)*

*checks the allowance before transfer from router*

*transfers input token, which is different from the vault asset, to the form*

*the balance of vault tokens, ready to be deposited is compared with the previous balance*

*notice the inscribed singleVaultData_.amount is deposited regardless if txData exists or not*

*this is always the estimated value post any swaps (if they exist)*

*the balance check above implies that a certain dust may be left in the superform after depositing*

*the vault asset (collateral) is approved and deposited to the vault*


```solidity
struct ProcessDirectWithdawLocalVars {
    uint64 chainId;
    address collateral;
    address receiver;
    address bridgeValidator;
    uint256 len1;
    uint256 amount;
    IERC4626 v;
}
```

### xChainWithdrawLocalVars
*pulling from sender, to auto-send tokens back in case of failed deposits / reverts*

*allowance is modified inside of the IERC20.transferFrom() call*

*This makes ERC4626Form (address(this)) owner of v.shares*


```solidity
struct xChainWithdrawLocalVars {
    uint64 dstChainId;
    address receiver;
    address collateral;
    address bridgeValidator;
    uint256 balanceBefore;
    uint256 balanceAfter;
    uint256 amount;
}
```

