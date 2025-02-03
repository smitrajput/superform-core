# VaaKey
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/wormhole/IWormholeRelayer.sol)

**Author:**


This project allows developers to build cross-chain applications powered by Wormhole without needing to
write and run their own relaying infrastructure
We implement the IWormholeRelayer interface that allows users to request a delivery provider to relay a payload
(and/or additional VAAs)
to a chain and address of their choice.

VaaKey identifies a wormhole message

**Notes:**
- member: chainId Wormhole chain ID of the chain where this VAA was emitted from

- member: emitterAddress Address of the emitter of the VAA, in Wormhole bytes32 format

- member: sequence Sequence number of the VAA


```solidity
struct VaaKey {
    uint16 chainId;
    bytes32 emitterAddress;
    uint64 sequence;
}
```

