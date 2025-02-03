# IBaseRouterImplementation
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/interfaces/IBaseRouterImplementation.sol)

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

