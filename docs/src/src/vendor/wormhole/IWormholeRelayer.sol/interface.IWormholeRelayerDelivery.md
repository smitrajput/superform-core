# IWormholeRelayerDelivery
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/wormhole/IWormholeRelayer.sol)

**Inherits:**
[IWormholeRelayerBase](/src/vendor/wormhole/IWormholeRelayer.sol/interface.IWormholeRelayerBase.md)

The interface to execute deliveries. Only relevant for Delivery Providers


## Functions
### deliver

The delivery provider calls `deliver` to relay messages as described by one delivery instruction
The delivery provider must pass in the specified (by VaaKeys[]) signed wormhole messages (VAAs) from the source
chain
as well as the signed wormhole message with the delivery instructions (the delivery VAA)
The messages will be relayed to the target address (with the specified gas limit and receiver value) iff the
following checks are met:
- the delivery VAA has a valid signature
- the delivery VAA's emitter is one of these WormholeRelayer contracts
- the delivery provider passed in at least enough of this chain's currency as msg.value (enough meaning the
maximum possible refund)
- the instruction's target chain is this chain
- the relayed signed VAAs match the descriptions in container.messages (the VAA hashes match, or the emitter
address, sequence number pair matches, depending on the description given)


```solidity
function deliver(
    bytes[] memory encodedVMs,
    bytes memory encodedDeliveryVAA,
    address payable relayerRefundAddress,
    bytes memory deliveryOverrides
)
    external
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`encodedVMs`|`bytes[]`|- An array of signed wormhole messages (all from the same source chain transaction)|
|`encodedDeliveryVAA`|`bytes`|- Signed wormhole message from the source chain's WormholeRelayer contract with payload being the encoded delivery instruction container|
|`relayerRefundAddress`|`address payable`|- The address to which any refunds to the delivery provider should be sent|
|`deliveryOverrides`|`bytes`|- Optional overrides field which must be either an empty bytes array or an encoded DeliveryOverride struct|


## Events
### Delivery
**Notes:**
- member: recipientContract - The target contract address

- member: sourceChain - The chain which this delivery was requested from (in wormhole
ChainID format)

- member: sequence - The wormhole sequence number of the delivery VAA on the source chain
corresponding to this delivery request

- member: deliveryVaaHash - The hash of the delivery VAA corresponding to this delivery
request

- member: gasUsed - The amount of gas that was used to call your target contract

- member: status:
- RECEIVER_FAILURE, if the target contract reverts
- SUCCESS, if the target contract doesn't revert

- member: additionalStatusInfo:
- If status is SUCCESS, then this is empty.
- If status is RECEIVER_FAILURE, this is `RETURNDATA_TRUNCATION_THRESHOLD` bytes of the
return data (i.e. potentially truncated revert reason information).

- member: refundStatus - Result of the refund. REFUND_SUCCESS or REFUND_FAIL are for
refunds where targetChain=refundChain; the others are for targetChain!=refundChain,
where a cross chain refund is necessary

- member: overridesInfo:
- If not an override: empty bytes array
- Otherwise: An encoded `DeliveryOverride`


```solidity
event Delivery(
    address indexed recipientContract,
    uint16 indexed sourceChain,
    uint64 indexed sequence,
    bytes32 deliveryVaaHash,
    DeliveryStatus status,
    uint256 gasUsed,
    RefundStatus refundStatus,
    bytes additionalStatusInfo,
    bytes overridesInfo
);
```

## Enums
### DeliveryStatus

```solidity
enum DeliveryStatus {
    SUCCESS,
    RECEIVER_FAILURE
}
```

### RefundStatus

```solidity
enum RefundStatus {
    REFUND_SENT,
    REFUND_FAIL,
    CROSS_CHAIN_REFUND_SENT,
    CROSS_CHAIN_REFUND_FAIL_PROVIDER_NOT_SUPPORTED,
    CROSS_CHAIN_REFUND_FAIL_NOT_ENOUGH
}
```

