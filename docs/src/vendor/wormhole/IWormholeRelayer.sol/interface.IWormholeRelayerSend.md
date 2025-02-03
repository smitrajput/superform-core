# IWormholeRelayerSend
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/vendor/wormhole/IWormholeRelayer.sol)

**Inherits:**
[IWormholeRelayerBase](/src/vendor/wormhole/IWormholeRelayer.sol/interface.IWormholeRelayerBase.md)

The interface to request deliveries


## Functions
### sendPayloadToEvm

Publishes an instruction for the default delivery provider
to relay a payload to the address `targetAddress` on chain `targetChain`
with gas limit `gasLimit` and `msg.value` equal to `receiverValue`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to `quoteEVMDeliveryPrice(targetChain, receiverValue,
gasLimit)`
Any refunds (from leftover gas) will be paid to the delivery provider. In order to receive the refunds, use the
`sendPayloadToEvm` function
with `refundChain` and `refundAddress` as parameters


```solidity
function sendPayloadToEvm(
    uint16 targetChain,
    address targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 gasLimit
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`address`|address to call on targetChain (that implements IWormholeReceiver)|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### sendPayloadToEvm

Publishes an instruction for the default delivery provider
to relay a payload to the address `targetAddress` on chain `targetChain`
with gas limit `gasLimit` and `msg.value` equal to `receiverValue`
Any refunds (from leftover gas) will be sent to `refundAddress` on chain `refundChain`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to `quoteEVMDeliveryPrice(targetChain, receiverValue,
gasLimit)`


```solidity
function sendPayloadToEvm(
    uint16 targetChain,
    address targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 gasLimit,
    uint16 refundChain,
    address refundAddress
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`address`|address to call on targetChain (that implements IWormholeReceiver)|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`. Any units of gas unused will be refunded according to the `targetChainRefundPerGasUnused` rate quoted by the delivery provider|
|`refundChain`|`uint16`|The chain to deliver any refund to, in Wormhole Chain ID format|
|`refundAddress`|`address`|The address on `refundChain` to deliver any refund to|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### sendVaasToEvm

Publishes an instruction for the default delivery provider
to relay a payload and VAAs specified by `vaaKeys` to the address `targetAddress` on chain `targetChain`
with gas limit `gasLimit` and `msg.value` equal to `receiverValue`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to `quoteEVMDeliveryPrice(targetChain, receiverValue,
gasLimit)`
Any refunds (from leftover gas) will be paid to the delivery provider. In order to receive the refunds, use the
`sendVaasToEvm` function
with `refundChain` and `refundAddress` as parameters


```solidity
function sendVaasToEvm(
    uint16 targetChain,
    address targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 gasLimit,
    VaaKey[] memory vaaKeys
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`address`|address to call on targetChain (that implements IWormholeReceiver)|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`.|
|`vaaKeys`|`VaaKey[]`|Additional VAAs to pass in as parameter in call to `targetAddress`|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### sendVaasToEvm

Publishes an instruction for the default delivery provider
to relay a payload and VAAs specified by `vaaKeys` to the address `targetAddress` on chain `targetChain`
with gas limit `gasLimit` and `msg.value` equal to `receiverValue`
Any refunds (from leftover gas) will be sent to `refundAddress` on chain `refundChain`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to `quoteEVMDeliveryPrice(targetChain, receiverValue,
gasLimit)`


```solidity
function sendVaasToEvm(
    uint16 targetChain,
    address targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 gasLimit,
    VaaKey[] memory vaaKeys,
    uint16 refundChain,
    address refundAddress
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`address`|address to call on targetChain (that implements IWormholeReceiver)|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`. Any units of gas unused will be refunded according to the `targetChainRefundPerGasUnused` rate quoted by the delivery provider|
|`vaaKeys`|`VaaKey[]`|Additional VAAs to pass in as parameter in call to `targetAddress`|
|`refundChain`|`uint16`|The chain to deliver any refund to, in Wormhole Chain ID format|
|`refundAddress`|`address`|The address on `refundChain` to deliver any refund to|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### sendToEvm

Publishes an instruction for the delivery provider at `deliveryProviderAddress`
to relay a payload and VAAs specified by `vaaKeys` to the address `targetAddress` on chain `targetChain`
with gas limit `gasLimit` and `msg.value` equal to
receiverValue + (arbitrary amount that is paid for by paymentForExtraReceiverValue of this chain's wei) in
targetChain wei.
Any refunds (from leftover gas) will be sent to `refundAddress` on chain `refundChain`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to
quoteEVMDeliveryPrice(targetChain, receiverValue, gasLimit, deliveryProviderAddress) +
paymentForExtraReceiverValue


```solidity
function sendToEvm(
    uint16 targetChain,
    address targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 paymentForExtraReceiverValue,
    uint256 gasLimit,
    uint16 refundChain,
    address refundAddress,
    address deliveryProviderAddress,
    VaaKey[] memory vaaKeys,
    uint8 consistencyLevel
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`address`|address to call on targetChain (that implements IWormholeReceiver)|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`paymentForExtraReceiverValue`|`uint256`|amount (in current chain currency units) to spend on extra receiverValue (in addition to the `receiverValue` specified)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`. Any units of gas unused will be refunded according to the `targetChainRefundPerGasUnused` rate quoted by the delivery provider|
|`refundChain`|`uint16`|The chain to deliver any refund to, in Wormhole Chain ID format|
|`refundAddress`|`address`|The address on `refundChain` to deliver any refund to|
|`deliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|
|`vaaKeys`|`VaaKey[]`|Additional VAAs to pass in as parameter in call to `targetAddress`|
|`consistencyLevel`|`uint8`|Consistency level with which to publish the delivery instructions - see https://book.wormhole.com/wormhole/3_coreLayerContracts.html?highlight=consistency#consistency-levels|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### send

Publishes an instruction for the delivery provider at `deliveryProviderAddress`
to relay a payload and VAAs specified by `vaaKeys` to the address `targetAddress` on chain `targetChain`
with `msg.value` equal to
receiverValue + (arbitrary amount that is paid for by paymentForExtraReceiverValue of this chain's wei) in
targetChain wei.
Any refunds (from leftover gas) will be sent to `refundAddress` on chain `refundChain`
`targetAddress` must implement the IWormholeReceiver interface
This function must be called with `msg.value` equal to
quoteDeliveryPrice(targetChain, receiverValue, encodedExecutionParameters, deliveryProviderAddress) +
paymentForExtraReceiverValue


```solidity
function send(
    uint16 targetChain,
    bytes32 targetAddress,
    bytes memory payload,
    uint256 receiverValue,
    uint256 paymentForExtraReceiverValue,
    bytes memory encodedExecutionParameters,
    uint16 refundChain,
    bytes32 refundAddress,
    address deliveryProviderAddress,
    VaaKey[] memory vaaKeys,
    uint8 consistencyLevel
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`targetAddress`|`bytes32`|address to call on targetChain (that implements IWormholeReceiver), in Wormhole bytes32 format|
|`payload`|`bytes`|arbitrary bytes to pass in as parameter in call to `targetAddress`|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`paymentForExtraReceiverValue`|`uint256`|amount (in current chain currency units) to spend on extra receiverValue (in addition to the `receiverValue` specified)|
|`encodedExecutionParameters`|`bytes`|encoded information on how to execute delivery that may impact pricing e.g. for version EVM_V1, this is a struct that encodes the `gasLimit` with which to call `targetAddress`|
|`refundChain`|`uint16`|The chain to deliver any refund to, in Wormhole Chain ID format|
|`refundAddress`|`bytes32`|The address on `refundChain` to deliver any refund to, in Wormhole bytes32 format|
|`deliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|
|`vaaKeys`|`VaaKey[]`|Additional VAAs to pass in as parameter in call to `targetAddress`|
|`consistencyLevel`|`uint8`|Consistency level with which to publish the delivery instructions - see https://book.wormhole.com/wormhole/3_coreLayerContracts.html?highlight=consistency#consistency-levels|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing delivery instructions|


### resendToEvm

Requests a previously published delivery instruction to be redelivered
(e.g. with a different delivery provider)
This function must be called with `msg.value` equal to
quoteEVMDeliveryPrice(targetChain, newReceiverValue, newGasLimit, newDeliveryProviderAddress)

*** This will only be able to succeed if the following is true **
- newGasLimit >= gas limit of the old instruction
- newReceiverValue >= receiver value of the old instruction
- newDeliveryProvider's `targetChainRefundPerGasUnused` >= old relay provider's
`targetChainRefundPerGasUnused`

*** This will only be able to succeed if the following is true **
- newGasLimit >= gas limit of the old instruction
- newReceiverValue >= receiver value of the old instruction
- newDeliveryProvider's `targetChainRefundPerGasUnused` >= old relay provider's
`targetChainRefundPerGasUnused`


```solidity
function resendToEvm(
    VaaKey memory deliveryVaaKey,
    uint16 targetChain,
    uint256 newReceiverValue,
    uint256 newGasLimit,
    address newDeliveryProviderAddress
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`deliveryVaaKey`|`VaaKey`|VaaKey identifying the wormhole message containing the previously published delivery instructions|
|`targetChain`|`uint16`|The target chain that the original delivery targeted. Must match targetChain from original delivery instructions|
|`newReceiverValue`|`uint256`|new msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`newGasLimit`|`uint256`|gas limit with which to call `targetAddress`. Any units of gas unused will be refunded according to the `targetChainRefundPerGasUnused` rate quoted by the delivery provider, to the refund chain and address specified in the original request|
|`newDeliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing redelivery instructions|


### resend

Requests a previously published delivery instruction to be redelivered
This function must be called with `msg.value` equal to
quoteDeliveryPrice(targetChain, newReceiverValue, newEncodedExecutionParameters, newDeliveryProviderAddress)

*** This will only be able to succeed if the following is true **
- (For EVM_V1) newGasLimit >= gas limit of the old instruction
- newReceiverValue >= receiver value of the old instruction
- (For EVM_V1) newDeliveryProvider's `targetChainRefundPerGasUnused` >= old relay provider's
`targetChainRefundPerGasUnused`


```solidity
function resend(
    VaaKey memory deliveryVaaKey,
    uint16 targetChain,
    uint256 newReceiverValue,
    bytes memory newEncodedExecutionParameters,
    address newDeliveryProviderAddress
)
    external
    payable
    returns (uint64 sequence);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`deliveryVaaKey`|`VaaKey`|VaaKey identifying the wormhole message containing the previously published delivery instructions|
|`targetChain`|`uint16`|The target chain that the original delivery targeted. Must match targetChain from original delivery instructions|
|`newReceiverValue`|`uint256`|new msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`newEncodedExecutionParameters`|`bytes`|new encoded information on how to execute delivery that may impact pricing e.g. for version EVM_V1, this is a struct that encodes the `gasLimit` with which to call `targetAddress`|
|`newDeliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`sequence`|`uint64`|sequence number of published VAA containing redelivery instructions|


### quoteEVMDeliveryPrice

Returns the price to request a relay to chain `targetChain`, using the default delivery provider


```solidity
function quoteEVMDeliveryPrice(
    uint16 targetChain,
    uint256 receiverValue,
    uint256 gasLimit
)
    external
    view
    returns (uint256 nativePriceQuote, uint256 targetChainRefundPerGasUnused);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`nativePriceQuote`|`uint256`|Price, in units of current chain currency, that the delivery provider charges to perform the relay|
|`targetChainRefundPerGasUnused`|`uint256`|amount of target chain currency that will be refunded per unit of gas unused, if a refundAddress is specified|


### quoteEVMDeliveryPrice

Returns the price to request a relay to chain `targetChain`, using delivery provider
`deliveryProviderAddress`


```solidity
function quoteEVMDeliveryPrice(
    uint16 targetChain,
    uint256 receiverValue,
    uint256 gasLimit,
    address deliveryProviderAddress
)
    external
    view
    returns (uint256 nativePriceQuote, uint256 targetChainRefundPerGasUnused);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`gasLimit`|`uint256`|gas limit with which to call `targetAddress`.|
|`deliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`nativePriceQuote`|`uint256`|Price, in units of current chain currency, that the delivery provider charges to perform the relay|
|`targetChainRefundPerGasUnused`|`uint256`|amount of target chain currency that will be refunded per unit of gas unused, if a refundAddress is specified|


### quoteDeliveryPrice

Returns the price to request a relay to chain `targetChain`, using delivery provider
`deliveryProviderAddress`


```solidity
function quoteDeliveryPrice(
    uint16 targetChain,
    uint256 receiverValue,
    bytes memory encodedExecutionParameters,
    address deliveryProviderAddress
)
    external
    view
    returns (uint256 nativePriceQuote, bytes memory encodedExecutionInfo);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`receiverValue`|`uint256`|msg.value that delivery provider should pass in for call to `targetAddress` (in targetChain currency units)|
|`encodedExecutionParameters`|`bytes`|encoded information on how to execute delivery that may impact pricing e.g. for version EVM_V1, this is a struct that encodes the `gasLimit` with which to call `targetAddress`|
|`deliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`nativePriceQuote`|`uint256`|Price, in units of current chain currency, that the delivery provider charges to perform the relay|
|`encodedExecutionInfo`|`bytes`|encoded information on how the delivery will be executed e.g. for version EVM_V1, this is a struct that encodes the `gasLimit` and `targetChainRefundPerGasUnused` (which is the amount of target chain currency that will be refunded per unit of gas unused, if a refundAddress is specified)|


### quoteNativeForChain

Returns the (extra) amount of target chain currency that `targetAddress`
will be called with, if the `paymentForExtraReceiverValue` field is set to `currentChainAmount`


```solidity
function quoteNativeForChain(
    uint16 targetChain,
    uint256 currentChainAmount,
    address deliveryProviderAddress
)
    external
    view
    returns (uint256 targetChainAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targetChain`|`uint16`|in Wormhole Chain ID format|
|`currentChainAmount`|`uint256`|The value that `paymentForExtraReceiverValue` will be set to|
|`deliveryProviderAddress`|`address`|The address of the desired delivery provider's implementation of IDeliveryProvider|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`targetChainAmount`|`uint256`|The amount such that if `targetAddress` will be called with `msg.value` equal to receiverValue + targetChainAmount|


### getDefaultDeliveryProvider

Returns the address of the current default delivery provider


```solidity
function getDefaultDeliveryProvider() external view returns (address deliveryProvider);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`deliveryProvider`|`address`|The address of (the default delivery provider)'s contract on this source chain. This must be a contract that implements IDeliveryProvider.|


