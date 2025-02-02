# ArrayCastLib
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/libraries/ArrayCastLib.sol)

not gas optimized, suggested for usage only in view/pure functions

*library to cast single values into array for streamlining helper functions*


## Functions
### castToArray


```solidity
function castToArray(LiqRequest memory value_) internal pure returns (LiqRequest[] memory values);
```

