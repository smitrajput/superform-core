# CallbackType
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/types/DataTypes.sol)

*Message types can be INIT, RETURN (for successful Deposits) and FAIL (for failed withdraws)*


```solidity
enum CallbackType {
    INIT,
    RETURN,
    FAIL
}
```

