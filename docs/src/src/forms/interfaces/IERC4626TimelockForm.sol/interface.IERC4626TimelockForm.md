# IERC4626TimelockForm
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/forms/interfaces/IERC4626TimelockForm.sol)

**Inherits:**
[IERC4626Form](/src/forms/interfaces/IERC4626Form.sol/interface.IERC4626Form.md)

**Author:**
Zeropoint Labs

SPDX-License-Identifier: Apache-2.0

Interface used by ERC4626TimelockForm. Required by TwostepsFormStateRegistry to call processUnlock()
function


## Functions
### withdrawAfterCoolDown

Process unlock request


```solidity
function withdrawAfterCoolDown(uint256 amount_, TimelockPayload memory p_) external;
```

### unlockId


```solidity
function unlockId(uint256 unlockCounter_) external view returns (InitSingleVaultData memory singleVaultData);
```

