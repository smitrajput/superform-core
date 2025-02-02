# BaseRouterImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/BaseRouterImplementation.sol)

**Inherits:**
[IBaseRouterImplementation](/src/interfaces/IBaseRouterImplementation.sol/interface.IBaseRouterImplementation.md), [BaseRouter](/src/BaseRouter.sol/abstract.BaseRouter.md), [LiquidityHandler](/src/crosschain-liquidity/LiquidityHandler.sol/abstract.LiquidityHandler.md)

**Author:**
Zeropoint Labs

SPDX-License-Identifier: Apache-2.0

*Extends BaseRouter with standard internal execution functions (based on SuperPositions)*


## State Variables
### payloadIds
*tracks the total payloads*


```solidity
uint256 public payloadIds;
```


## Functions
### constructor


```solidity
constructor(
    address superRegistry_,
    uint8 stateRegistryType_,
    uint8 routerType_
)
    BaseRouter(superRegistry_, stateRegistryType_, routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|
|`stateRegistryType_`|`uint8`|the state registry type|
|`routerType_`|`uint8`|the router type|


### _singleXChainMultiVaultDeposit

*handles cross-chain multi vault deposit*


```solidity
function _singleXChainMultiVaultDeposit(SingleXChainMultiVaultStateReq memory req_) internal virtual;
```

### _singleXChainSingleVaultDeposit

*validate superformsData*

*this loop is what allows to deposit to >1 different underlying on destination*

*if a loop fails in a validation the whole chain should be reverted*

*dispatch liquidity data*

*dispatch message information, notice multiVaults is set to 1*

*handles cross-chain single vault deposit*


```solidity
function _singleXChainSingleVaultDeposit(SingleXChainSingleVaultStateReq memory req_) internal virtual;
```

### _singleDirectSingleVaultDeposit

*disallow direct chain actions*

*this step validates and returns ambData from the state request*

*dispatch liquidity data*

*dispatch message information, notice multiVaults is set to 0*

*handles same-chain single vault deposit*


```solidity
function _singleDirectSingleVaultDeposit(SingleDirectSingleVaultStateReq memory req_) internal virtual;
```

### _singleDirectMultiVaultDeposit

*same chain action & forward residual payment to payment collector*

*handles same-chain multi vault deposit*


```solidity
function _singleDirectMultiVaultDeposit(SingleDirectMultiVaultStateReq memory req_) internal virtual;
```

### _singleXChainMultiVaultWithdraw

*same chain action & forward residual payment to payment collector*

*handles cross-chain multi vault withdraw*


```solidity
function _singleXChainMultiVaultWithdraw(SingleXChainMultiVaultStateReq memory req_) internal virtual;
```

### _singleXChainSingleVaultWithdraw

*validate superformsData*

*write packed txData*

*dispatch message information, notice multiVaults is set to 1*

*handles cross-chain single vault withdraw*


```solidity
function _singleXChainSingleVaultWithdraw(SingleXChainSingleVaultStateReq memory req_) internal virtual;
```

### _singleDirectSingleVaultWithdraw

*this step validates and returns ambData from the state request*

*dispatch message information, notice multiVaults is set to 0*

*handles same-chain single vault withdraw*


```solidity
function _singleDirectSingleVaultWithdraw(SingleDirectSingleVaultStateReq memory req_) internal virtual;
```

### _singleDirectMultiVaultWithdraw

*same chain action*

*handles same-chain multi vault withdraw*


```solidity
function _singleDirectMultiVaultWithdraw(SingleDirectMultiVaultStateReq memory req_) internal virtual;
```

### _buildDepositAmbData

*SuperPositions are burnt optimistically here*

*same chain action & forward residual payment to payment collector*

*internal function used for validation and ambData building across different entry points*


```solidity
function _buildDepositAmbData(
    uint64 dstChainId_,
    SingleVaultSFData memory superformData_
)
    internal
    virtual
    returns (InitSingleVaultData memory ambData, uint256 currentPayloadId);
```

### _buildWithdrawAmbData

*validate superformsData*


```solidity
function _buildWithdrawAmbData(
    address srcSender_,
    uint64 dstChainId_,
    SingleVaultSFData memory superformData_
)
    internal
    virtual
    returns (InitSingleVaultData memory ambData, uint256 currentPayloadId);
```

### _validateAndDispatchTokens


```solidity
function _validateAndDispatchTokens(ValidateAndDispatchTokensArgs memory args_) internal virtual;
```

### _dispatchAmbMessage

*validates remaining params of txData*

*dispatches tokens through the selected liquidity bridge to the destination contract*


```solidity
function _dispatchAmbMessage(DispatchAMBMessageVars memory vars_) internal virtual;
```

### _directSingleDeposit

deposits to single vault on the same chain

*this call dispatches the message to the AMB bridge through dispatchPayload*

*calls `_directDeposit`*


```solidity
function _directSingleDeposit(
    address srcSender_,
    bytes memory permit2data_,
    InitSingleVaultData memory vaultData_
)
    internal
    virtual;
```

### _directMultiDeposit

deposits to multiple vaults on the same chain

*loops and call `_directDeposit`*


```solidity
function _directMultiDeposit(
    address srcSender_,
    bytes memory permit2data_,
    InitMultiVaultData memory vaultData_
)
    internal
    virtual;
```

### _directDeposit

fulfils the final stage of same chain deposit action

*decode superforms*

*deposits collateral to a given vault and mint vault positions.*

*in direct deposits, SuperPositions are minted right after depositing to vaults*


```solidity
function _directDeposit(
    address superform_,
    uint8 superformRouterId_,
    uint256 payloadId_,
    uint256 superformId_,
    uint256 amount_,
    uint256 maxSlippage_,
    LiqRequest memory liqData_,
    bytes memory extraFormData_,
    uint256 msgValue_,
    address srcSender_
)
    internal
    virtual
    returns (uint256 dstAmount);
```

### _directSingleWithdraw

withdraws from single vault on the same chain

*validates if superformId exists on factory*

*deposits collateral to a given vault and mint vault positions directly through the form
no need for a refund address*

*call `_directWithdraw`*


```solidity
function _directSingleWithdraw(InitSingleVaultData memory vaultData_, address srcSender_) internal virtual;
```

### _directMultiWithdraw

withdraws from multiple vaults on the same chain

*decode superforms*

*loops and call `_directWithdraw`*


```solidity
function _directMultiWithdraw(InitMultiVaultData memory vaultData_, address srcSender_) internal virtual;
```

### _directWithdraw

fulfils the final stage of same chain withdrawal action

*decode superforms*

*deposits collateral to a given vault and mint vault positions.*


```solidity
function _directWithdraw(
    address superform_,
    uint8 superformRouterId_,
    uint256 payloadId_,
    uint256 superformId_,
    uint256 amount_,
    uint256 maxSlippage_,
    LiqRequest memory liqData_,
    bytes memory extraFormData_,
    address srcSender_,
    address refundAddress_
)
    internal
    virtual;
```

### _validateSuperformData

*validates if superformId exists on factory*

*in direct withdraws, form is called directly*


```solidity
function _validateSuperformData(
    uint64 dstChainId_,
    SingleVaultSFData memory superformData_
)
    internal
    view
    virtual
    returns (bool);
```

### _validateSuperformsDepositData

*the dstChainId_ (in the state request) must match the superforms' chainId (superform must exist on
destinatiom)*

*10000 = 100% slippage
if it reaches this point then is valid*


```solidity
function _validateSuperformsDepositData(
    MultiVaultSFData memory superformsData_,
    uint64 dstChainId_
)
    internal
    view
    virtual
    returns (bool);
```

### _validateSuperformsWithdrawData

*empty requests are not allowed, as well as requests with length mismatch*

*superformIds/amounts/slippages array sizes validation*

*slippage and paused status validation*

*10000 = 100% slippage*


```solidity
function _validateSuperformsWithdrawData(
    MultiVaultSFData memory superformsData_,
    uint64 dstChainId_
)
    internal
    view
    virtual
    returns (bool);
```

### _forwardPayment

*empty requests are not allowed, as well as requests with length mismatch*

*superformIds/amounts/slippages array sizes validation*

*slippage and paused status validation*

*10000 = 100% slippage*

*forwards the residual payment to payment collector*


```solidity
function _forwardPayment(uint256 _balanceBefore) internal virtual;
```

### _singleVaultTokenForward

*deducts what's already available sends what's left in msg.value to payment collector*


```solidity
function _singleVaultTokenForward(
    address srcSender_,
    address superform_,
    bytes memory permit2data_,
    InitSingleVaultData memory vaultData_
)
    internal
    virtual;
```

### _multiVaultTokenForward


```solidity
function _multiVaultTokenForward(
    address srcSender_,
    address[] memory targets_,
    bytes memory permit2data_,
    InitMultiVaultData memory vaultData_,
    bool xChain
)
    internal
    virtual;
```

## Structs
### ValidateAndDispatchTokensArgs
*validate superformsData*


```solidity
struct ValidateAndDispatchTokensArgs {
    LiqRequest liqRequest;
    address permit2;
    address superform;
    uint64 srcChainId;
    uint64 dstChainId;
    address srcSender;
    bool deposit;
}
```

### MultiDepositLocalVars
*decode superforms*

*deposits collateral to a given vault and mint vault positions.*

*mint super positions at the end of the deposit action*


```solidity
struct MultiDepositLocalVars {
    uint256 len;
    address[] superforms;
    uint256[] dstAmounts;
    bool mint;
}
```

### MultiTokenForwardLocalVars
e.g asset in is USDC (6 decimals), we use this amount to approve the transfer to superform

*moves the tokens from the user to the router*

*moves the tokens from the user to the router*

*approves the input amount to the superform*


```solidity
struct MultiTokenForwardLocalVars {
    IERC20 token;
    uint256 len;
    uint256 totalAmount;
    uint256 permit2dataLen;
    address permit2;
    uint256[] approvalAmounts;
}
```

