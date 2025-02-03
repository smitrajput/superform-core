# ArrayCastLib
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/libraries/ArrayCastLib.sol)

not gas optimized, suggested for usage only in view/pure functions

*library to cast single values into array for streamlining helper functions*


## Functions
### castToArray


```solidity
function castToArray(LiqRequest memory value_) internal pure returns (LiqRequest[] memory values);
```

