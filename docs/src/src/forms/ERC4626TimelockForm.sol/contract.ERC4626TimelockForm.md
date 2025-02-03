# ERC4626TimelockForm
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/forms/ERC4626TimelockForm.sol)

**Inherits:**
[ERC4626FormImplementation](/src/forms/ERC4626FormImplementation.sol/abstract.ERC4626FormImplementation.md)

Form implementation to handle timelock extension for ERC4626 vaults


## Functions
### onlyTwoStepStateRegistry


```solidity
modifier onlyTwoStepStateRegistry();
```

### constructor


```solidity
constructor(address superRegistry_) ERC4626FormImplementation(superRegistry_, 2);
```

### withdrawAfterCoolDown

*this function is called when the timelock deposit is ready to be withdrawn after being unlocked*


```solidity
function withdrawAfterCoolDown(
    uint256 amount_,
    TimelockPayload memory p_
)
    external
    onlyTwoStepStateRegistry
    returns (uint256 dstAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`amount_`|`uint256`|the amount of tokens to withdraw|
|`p_`|`TimelockPayload`|the payload data|


### _directDepositIntoVault

*a case where the withdraw req liqData has a valid token and tx data is not updated by the keeper*

*if the txData is empty, the tokens are sent directly to the sender, otherwise sent first to this form*

*validate and dispatches the tokens*

*the amount inscribed in liqData must be less or equal than the amount redeemed from the vault*

*validate and perform the swap to desired output token and send to beneficiary*


```solidity
function _directDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address
)
    internal
    virtual
    override
    returns (uint256 dstAmount);
```

### _directWithdrawFromVault

*this is the step-1 for two step form withdrawal, direct case*

*will mandatorily process unlock*


```solidity
function _directWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_
)
    internal
    virtual
    override
    returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|dstAmount is always 0|


### _xChainDepositIntoVault

*after requesting the unlock, the information with the time of full unlock is saved and sent to the two
step*

*state registry for re-processing at a later date*


```solidity
function _xChainDepositIntoVault(
    InitSingleVaultData memory singleVaultData_,
    address,
    uint64 srcChainId_
)
    internal
    virtual
    override
    returns (uint256 dstAmount);
```

### _xChainWithdrawFromVault

*this is the step-1 for two step form withdrawal, xchain case*

*will mandatorily process unlock*


```solidity
function _xChainWithdrawFromVault(
    InitSingleVaultData memory singleVaultData_,
    address srcSender_,
    uint64 srcChainId_
)
    internal
    virtual
    override
    returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|dstAmount is always 0|


### _emergencyWithdraw

*after requesting the unlock, the information with the time of full unlock is saved and sent to the two
step*

*state registry for re-processing at a later date*


```solidity
function _emergencyWithdraw(address refundAddress_, uint256 amount_) internal override;
```

### _requestUnlock

superPositions are already burned at this point

*calls the vault to request unlock*


```solidity
function _requestUnlock(uint256 amount_) internal returns (uint256 lockedTill_);
```

### _storePayload

*stores the withdrawal payload*


```solidity
function _storePayload(
    uint8 type_,
    address srcSender_,
    uint64 srcChainId_,
    uint256 lockedTill_,
    InitSingleVaultData memory data_
)
    internal;
```

## Structs
### withdrawAfterCoolDownLocalVars

```solidity
struct withdrawAfterCoolDownLocalVars {
    uint256 len1;
    address bridgeValidator;
    uint64 chainId;
    address receiver;
    uint256 amount;
    LiqRequest liqData;
}
```

