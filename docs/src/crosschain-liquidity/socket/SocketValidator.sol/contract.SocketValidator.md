# SocketValidator
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/crosschain-liquidity/socket/SocketValidator.sol)

**Inherits:**
[BridgeValidator](/src/crosschain-liquidity/BridgeValidator.sol/abstract.BridgeValidator.md)

**Author:**
Zeropoint Labs

*to assert input txData is valid*


## Functions
### constructor


```solidity
constructor(address superRegistry_) BridgeValidator(superRegistry_);
```

### validateLiqDstChainId


```solidity
function validateLiqDstChainId(bytes calldata txData_, uint64 liqDstChainId_) external pure override returns (bool);
```

### validateReceiver


```solidity
function validateReceiver(bytes calldata txData_, address receiver) external pure override returns (bool);
```

### validateTxData


```solidity
function validateTxData(ValidateTxDataArgs calldata args_) external view override;
```

### decodeMinAmountOut


```solidity
function decodeMinAmountOut(
    bytes calldata txData_,
    bool genericSwapDisallowed_
)
    external
    view
    override
    returns (uint256 amount_);
```

### decodeAmountIn


```solidity
function decodeAmountIn(
    bytes calldata txData_,
    bool genericSwapDisallowed_
)
    external
    view
    override
    returns (uint256 amount_);
```

### decodeDstSwap


```solidity
function decodeDstSwap(bytes calldata txData_) external pure override returns (address token_, uint256 amount_);
```

### _decodeTxData

*helps decode socket user request
returns the user request*


```solidity
function _decodeTxData(bytes calldata txData_)
    internal
    pure
    returns (ISocketRegistry.SocketRequest memory socketRequest);
```

### _parseCallData

*helps parsing socket calldata and return the socket request*


```solidity
function _parseCallData(bytes calldata callData) internal pure returns (bytes memory);
```

