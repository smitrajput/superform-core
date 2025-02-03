# PayloadState
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*Used only in withdraw flow now*

*Payloads are stored, updated (deposits) or processed (finalized)*


```solidity
enum PayloadState {
    STORED,
    UPDATED,
    PROCESSED
}
```

