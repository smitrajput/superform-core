# PayloadHelper
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/crosschain-data/utils/PayloadHelper.sol)

**Inherits:**
[IPayloadHelper](/src/interfaces/IPayloadHelper.sol/interface.IPayloadHelper.md)

**Author:**
ZeroPoint Labs

*helps decode payload data more easily. Used for off-chain purposes*


## State Variables
### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


## Functions
### constructor


```solidity
constructor(address superRegistry_);
```

### decodeCoreStateRegistryPayload

*reads the payload from the core state registry and decodes it in a more detailed manner.*


```solidity
function decodeCoreStateRegistryPayload(uint256 dstPayloadId_)
    external
    view
    override
    returns (
        uint8 txType,
        uint8 callbackType,
        address srcSender,
        uint64 srcChainId,
        uint256[] memory amounts,
        uint256[] memory slippage,
        uint256[] memory superformIds,
        uint256 srcPayloadId,
        uint8 superformRouterId
    );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dstPayloadId_`|`uint256`|is the unique identifier of the payload received in dst core state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`txType`|`uint8`|is the type of transaction. check {TransactionType} enum in DataTypes.sol|
|`callbackType`|`uint8`|is the type of payload. check {CallbackType} enum in DataTypes.sol|
|`srcSender`|`address`|is the user who initiated the transaction on the srcChain|
|`srcChainId`|`uint64`|is the unique identifier of the srcChain|
|`amounts`|`uint256[]`|is the amount to deposit/withdraw|
|`slippage`|`uint256[]`|is the max slippage configured by the user (only for deposits)|
|`superformIds`|`uint256[]`|is the unique identifiers of the superforms|
|`srcPayloadId`|`uint256`|is the identifier of the corresponding payload on srcChain|
|`superformRouterId`|`uint8`|is the identifier of the superform router|


### decodeCoreStateRegistryPayloadLiqData

*reads the payload from the core state registry and decodes liqData for it (to be used in withdraw cases)*


```solidity
function decodeCoreStateRegistryPayloadLiqData(uint256 dstPayloadId_)
    external
    view
    override
    returns (
        uint8[] memory bridgeIds,
        bytes[] memory txDatas,
        address[] memory tokens,
        uint64[] memory liqDstChainIds,
        uint256[] memory amountsIn,
        uint256[] memory amountsOut,
        uint256[] memory nativeAmounts,
        bool[] memory hasDstSwaps,
        address dstRefundAddress
    );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dstPayloadId_`|`uint256`|is the unique identifier of the payload received in dst core state registry|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`bridgeIds`|`uint8[]`|is the ids of the bridges to be used|
|`txDatas`|`bytes[]`|is the array of txData to be sent to the bridges|
|`tokens`|`address[]`|is the tokens to be used in the liqData|
|`liqDstChainIds`|`uint64[]`|are the final destination chain id for the underlying token (can be arbitrary on withdraws)|
|`amountsIn`|`uint256[]`|are the from amounts to the liquidity bridge|
|`amountsOut`|`uint256[]`|are the minimum amounts to be bridged through the liquidity bridge|
|`nativeAmounts`|`uint256[]`|is the native amounts to be used in the liqData|
|`hasDstSwaps`|`bool[]`|is the array of flags indicating if the original liqData has a dstSwaps|
|`dstRefundAddress`|`address`|is the address to be used for refunds|


### decodeStateSyncerPayloadHistory

*reads the payload header from a state syncer and decodes it.*


```solidity
function decodeStateSyncerPayloadHistory(
    uint256 srcPayloadId_,
    uint8 superformRouterId_
)
    external
    view
    override
    returns (uint8 txType, uint8 callbackType, uint8 multi, address srcSender, uint64 srcChainId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`srcPayloadId_`|`uint256`|is the unique identifier of the payload allocated by super router|
|`superformRouterId_`|`uint8`|is the unique identifier of the superform router|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`txType`|`uint8`|is the type of transaction. check {TransactionType} enum in DataTypes.sol|
|`callbackType`|`uint8`|is the type of payload. check {CallbackType} enum in DataTypes.sol|
|`multi`|`uint8`|isMulti indicates if the transaction involves operations to multiple vaults|
|`srcSender`|`address`|is the user who initiated the transaction on the srcChain|
|`srcChainId`|`uint64`|is the unique identifier of the srcChain|


### decodeTimeLockPayload

*returns decoded two step form payloads*


```solidity
function decodeTimeLockPayload(uint256 timelockPayloadId_)
    external
    view
    override
    returns (address srcSender, uint64 srcChainId, uint256 srcPayloadId, uint256 superformId, uint256 amount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`timelockPayloadId_`|`uint256`|is the unique identifier of payload in two step registry|


### decodeTimeLockFailedPayload


```solidity
function decodeTimeLockFailedPayload(uint256 timelockPayloadId_)
    external
    view
    override
    returns (address srcSender, uint64 srcChainId, uint256 srcPayloadId, uint256 superformId, uint256 amount);
```

## Structs
### DecodeDstPayloadInternalVars

```solidity
struct DecodeDstPayloadInternalVars {
    uint8 txType;
    uint8 callbackType;
    address srcSender;
    uint64 srcChainId;
    uint256[] amounts;
    uint256[] slippage;
    uint256[] superformIds;
    uint256 srcPayloadId;
    uint8 superformRouterId;
    uint8 multi;
    ReturnMultiData rd;
    ReturnSingleData rsd;
    InitMultiVaultData imvd;
    InitSingleVaultData isvd;
}
```

### DecodeDstPayloadLiqDataInternalVars

```solidity
struct DecodeDstPayloadLiqDataInternalVars {
    uint8 callbackType;
    uint8 multi;
    uint8[] bridgeIds;
    bytes[] txDatas;
    address[] liqDataTokens;
    uint64[] liqDataChainIds;
    uint256[] liqDataAmountsIn;
    uint256[] liqDataAmountsOut;
    uint256[] liqDataNativeAmounts;
    bool[] hasDstSwaps;
    address dstRefundAddress;
    InitMultiVaultData imvd;
    InitSingleVaultData isvd;
    uint256 i;
}
```

