# IBaseRouterImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/interfaces/IBaseRouterImplementation.sol)

**Inherits:**
[IBaseRouter](/src/interfaces/IBaseRouter.sol/interface.IBaseRouter.md)

**Author:**
Zeropoint Labs.

*interface for BaseRouterImplementation*


## Events
### CrossChainInitiated
*is emitted when a cross-chain transaction is initiated.*


```solidity
event CrossChainInitiated(uint256 indexed payloadId);
```

### Completed
*is emitted when a cross-chain transaction is completed.*


```solidity
event Completed(uint256 payloadId);
```

## Structs
### ActionLocalVars
*For local memory variable loading and avoiding stack too deep errors*


```solidity
struct ActionLocalVars {
    AMBMessage ambMessage;
    LiqRequest liqRequest;
    uint64 srcChainId;
    uint256 currentPayloadId;
    uint256 liqRequestsLen;
}
```

### DispatchAMBMessageVars

```solidity
struct DispatchAMBMessageVars {
    TransactionType txType;
    bytes ambData;
    uint256[] superformIds;
    address srcSender;
    uint8[] ambIds;
    uint8 multiVaults;
    uint64 srcChainId;
    uint64 dstChainId;
    uint256 currentPayloadId;
}
```

