# CallbackType
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/types/DataTypes.sol)

*Message types can be INIT, RETURN (for successful Deposits) and FAIL (for failed withdraws)*


```solidity
enum CallbackType {
    INIT,
    RETURN,
    FAIL
}
```

