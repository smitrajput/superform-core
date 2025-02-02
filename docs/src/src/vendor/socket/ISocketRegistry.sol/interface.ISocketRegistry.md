# ISocketRegistry
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/socket/ISocketRegistry.sol)

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

