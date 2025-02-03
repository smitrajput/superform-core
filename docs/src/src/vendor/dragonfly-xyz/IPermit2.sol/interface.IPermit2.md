# IPermit2
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/dragonfly-xyz/IPermit2.sol)

**Author:**
https://github.com/dragonfly-xyz/useful-solidity-patterns/blob/main/patterns/permit2/Permit2Vault.sol

SPDX-License-Identifier: Apache-2.0

*Minimal Permit2 interface, derived from*

*https://github.com/Uniswap/permit2/blob/main/src/interfaces/ISignatureTransfer.sol*


## Functions
### permitTransferFrom


```solidity
function permitTransferFrom(
    PermitTransferFrom calldata permit,
    SignatureTransferDetails calldata transferDetails,
    address owner,
    bytes calldata signature
)
    external;
```

## Structs
### TokenPermissions

```solidity
struct TokenPermissions {
    IERC20 token;
    uint256 amount;
}
```

### PermitTransferFrom

```solidity
struct PermitTransferFrom {
    TokenPermissions permitted;
    uint256 nonce;
    uint256 deadline;
}
```

### SignatureTransferDetails

```solidity
struct SignatureTransferDetails {
    address to;
    uint256 requestedAmount;
}
```

