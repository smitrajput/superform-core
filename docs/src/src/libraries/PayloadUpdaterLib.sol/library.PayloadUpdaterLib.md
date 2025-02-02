# PayloadUpdaterLib
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/libraries/PayloadUpdaterLib.sol)

*library to validate slippage updation*


## Functions
### validateSlippage


```solidity
function validateSlippage(
    uint256 newAmount_,
    uint256 maxAmount_,
    uint256 slippage_
)
    internal
    pure
    returns (bool valid_);
```

### strictValidateSlippage

*args validation*

*amount must fall within the slippage bounds*


```solidity
function strictValidateSlippage(
    uint256 newAmount_,
    uint256 maxAmount_,
    uint256 slippage_
)
    internal
    pure
    returns (bool valid_);
```

### validateLiqReq

*args validation*

*amount must fall within the slippage bounds*


```solidity
function validateLiqReq(LiqRequest memory req_) internal pure;
```

### validateDepositPayloadUpdate

req token should be address(0)
req tx data length should be 0


```solidity
function validateDepositPayloadUpdate(
    uint256 txInfo_,
    PayloadState currentPayloadState_,
    uint8 isMulti_
)
    internal
    pure;
```

### validateWithdrawPayloadUpdate


```solidity
function validateWithdrawPayloadUpdate(
    uint256 txInfo_,
    PayloadState currentPayloadState_,
    uint8 isMulti_
)
    internal
    pure;
```

