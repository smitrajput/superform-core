# ISocketRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/socket/ISocketRegistry.sol)

Interface for socket's Router contract

taken from
https://github.com/SocketDotTech/socket-gateway-verifier


## Structs
### SocketRequest

```solidity
struct SocketRequest {
    uint256 amount;
    address recipient;
    uint256 toChainId;
    address token;
    bytes4 signature;
}
```

### UserRequest

```solidity
struct UserRequest {
    uint32 routeId;
    bytes socketRequest;
}
```

### UserRequestValidation

```solidity
struct UserRequestValidation {
    uint32 routeId;
    SocketRequest socketRequest;
}
```

