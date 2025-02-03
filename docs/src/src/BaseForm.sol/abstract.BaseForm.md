# BaseForm
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/BaseForm.sol)

**Inherits:**
Initializable, ERC165, [IBaseForm](/src/interfaces/IBaseForm.sol/interface.IBaseForm.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*Abstract contract to be inherited by different form implementations*


## State Variables
### PRECISION_DECIMALS

```solidity
uint256 internal constant PRECISION_DECIMALS = 27;
```


### PRECISION

```solidity
uint256 internal constant PRECISION = 10 ** PRECISION_DECIMALS;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### superRegistry
*The superRegistry address is used to access relevant protocol addresses*


```solidity
ISuperRegistry public immutable superRegistry;
```


### vault
*the vault this form pertains to*


```solidity
address public vault;
```


### formImplementationId

```solidity
uint32 public formImplementationId;
```


## Functions
### notPaused


```solidity
modifier notPaused(InitSingleVaultData memory singleVaultData_);
```

### onlySuperRouter


```solidity
modifier onlySuperRouter();
```

### onlyCoreStateRegistry


```solidity
modifier onlyCoreStateRegistry();
```

### onlyEmergencyQueue


```solidity
modifier onlyEmergencyQueue();
```

### constructor


```solidity
constructor(address superRegistry_);
```

### initialize

*sets caller as the admin of the contract.*


```solidity
function initialize(address superRegistry_, address vault_, uint32 formImplementationId_) external initializer;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|       ISuperRegistry address deployed|
|`vault_`|`address`|        The vault address this form pertains to|
|`formImplementationId_`|`uint32`||


### receive


```solidity
receive() external payable;
```

### supportsInterface


```solidity
function supportsInterface(bytes4 interfaceId_) public view virtual override(ERC165, IERC165) returns (bool);
```

### directDepositIntoVault

*process same chain id deposits*


```solidity
function directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    external
    payable
    override
    onlySuperRouter
    notPaused(singleVaultData_)
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
    override
    onlySuperRouter
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


```solidity
function xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    external
    override
    onlyCoreStateRegistry
    notPaused(singleVaultData_)
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
    override
    onlyCoreStateRegistry
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
function emergencyWithdraw(address refundAddress_, uint256 amount_) external override onlyEmergencyQueue;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`refundAddress_`|`address`|The address to refund the shares to|
|`amount_`|`uint256`|The amount of vault shares to refund|


### superformYieldTokenName

get Superform name of the ERC20 vault representation


```solidity
function superformYieldTokenName() external view virtual override returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The ERC20 name|


### superformYieldTokenSymbol

get Superform symbol of the ERC20 vault representation


```solidity
function superformYieldTokenSymbol() external view virtual override returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The ERC20 symbol|


### getVaultAsset

Returns the underlying token of a vault.


```solidity
function getVaultAsset() public view virtual override returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The asset being deposited into the vault used for accounting, depositing, and withdrawing|


### getVaultName

Returns the name of the vault.


```solidity
function getVaultName() public view virtual override returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The name of the vault|


### getVaultSymbol

Returns the symbol of a vault.


```solidity
function getVaultSymbol() public view virtual override returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The symbol associated with a vault|


### getVaultDecimals

Returns the number of decimals in a vault for accounting purposes


```solidity
function getVaultDecimals() public view virtual override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of decimals in the vault balance|


### getVaultAddress


```solidity
function getVaultAddress() external view override returns (address);
```

### getPricePerVaultShare

Returns the amount of underlying tokens each share of a vault is worth.


```solidity
function getPricePerVaultShare() public view virtual override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The pricePerVaultShare value|


### getVaultShareBalance

Returns the amount of vault shares owned by the form.


```solidity
function getVaultShareBalance() public view virtual override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The form's vault share balance|


### getTotalAssets

get the total amount of underlying managed in the ERC4626 vault


```solidity
function getTotalAssets() public view virtual override returns (uint256);
```

### getStateRegistryId

get the state registry id


```solidity
function getStateRegistryId() external view virtual override returns (uint256);
```

### getPreviewPricePerVaultShare


```solidity
function getPreviewPricePerVaultShare() public view virtual override returns (uint256);
```

### previewDepositTo

*API may need to know state of funds deployed*


```solidity
function previewDepositTo(uint256 assets_) public view virtual override returns (uint256);
```

### previewWithdrawFrom

positionBalance() -> .vaultIds&destAmounts


```solidity
function previewWithdrawFrom(uint256 assets_) public view virtual override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|how much of an asset + interest (accrued) is to withdraw from the Vault|


### previewRedeemFrom

*API may need to know state of funds deployed*


```solidity
function previewRedeemFrom(uint256 shares_) public view virtual override returns (uint256);
```

### _directDepositIntoVault

*Deposits underlying tokens into a vault*


```solidity
function _directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    internal
    virtual
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
    virtual
    returns (uint256 dstAmount_);
```

### _xChainDepositIntoVault

*Deposits underlying tokens into a vault*


```solidity
function _xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    virtual
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
    virtual
    returns (uint256 dstAmount);
```

### _emergencyWithdraw

*withdraws vault shares from form during emergency*


```solidity
function _emergencyWithdraw(address refundAddress_, uint256 amount_) internal virtual;
```

### _isPaused

*returns if a form id is paused*


```solidity
function _isPaused(uint256 superformId) internal view returns (bool);
```

### _vaultSharesAmountToUnderlyingAmount

*Converts a vault share amount into an equivalent underlying asset amount*


```solidity
function _vaultSharesAmountToUnderlyingAmount(
    uint256 vaultSharesAmount_,
    uint256 pricePerVaultShare_
)
    internal
    view
    virtual
    returns (uint256);
```

### _vaultSharesAmountToUnderlyingAmountRoundingUp

*Converts a vault share amount into an equivalent underlying asset amount, rounding up*


```solidity
function _vaultSharesAmountToUnderlyingAmountRoundingUp(
    uint256 vaultSharesAmount_,
    uint256 pricePerVaultShare_
)
    internal
    view
    virtual
    returns (uint256);
```

### _underlyingAmountToVaultSharesAmount

*Converts an underlying asset amount into an equivalent vault shares amount*


```solidity
function _underlyingAmountToVaultSharesAmount(
    uint256 underlyingAmount_,
    uint256 pricePerVaultShare_
)
    internal
    view
    virtual
    returns (uint256);
```

