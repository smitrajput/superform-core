# PaymentHelper
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/payments/PaymentHelper.sol)

**Inherits:**
[IPaymentHelper](/src/interfaces/IPaymentHelper.sol/interface.IPaymentHelper.md)

**Author:**
ZeroPoint Labs

*helps estimating the cost for the entire transaction lifecycle*


## State Variables
### superRegistry
*is the address of the superRegistry on the chain*


```solidity
ISuperRegistry public immutable superRegistry;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### NATIVE

```solidity
address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
```


### TIMELOCK_FORM_ID

```solidity
uint32 public constant TIMELOCK_FORM_ID = 1;
```


### nativeFeedOracle
*xchain params*


```solidity
mapping(uint64 chainId => AggregatorV3Interface) public nativeFeedOracle;
```


### gasPriceOracle

```solidity
mapping(uint64 chainId => AggregatorV3Interface) public gasPriceOracle;
```


### swapGasUsed

```solidity
mapping(uint64 chainId => uint256 gasForSwap) public swapGasUsed;
```


### updateGasUsed

```solidity
mapping(uint64 chainId => uint256 gasForUpdate) public updateGasUsed;
```


### depositGasUsed

```solidity
mapping(uint64 chainId => uint256 gasForOps) public depositGasUsed;
```


### withdrawGasUsed

```solidity
mapping(uint64 chainId => uint256 gasForOps) public withdrawGasUsed;
```


### nativePrice

```solidity
mapping(uint64 chainId => uint256 defaultNativePrice) public nativePrice;
```


### gasPrice

```solidity
mapping(uint64 chainId => uint256 defaultGasPrice) public gasPrice;
```


### gasPerKB

```solidity
mapping(uint64 chainId => uint256 gasPerKB) public gasPerKB;
```


### ackGasCost

```solidity
mapping(uint64 chainId => uint256 gasForOps) public ackGasCost;
```


### twoStepCost

```solidity
mapping(uint64 chainId => uint256 gasForOps) public twoStepCost;
```


## Functions
### onlyProtocolAdmin


```solidity
modifier onlyProtocolAdmin();
```

### onlyEmergencyAdmin


```solidity
modifier onlyEmergencyAdmin();
```

### constructor


```solidity
constructor(address superRegistry_);
```

### addChain

*admin config destination chain config for estimation*


```solidity
function addChain(uint64 chainId_, PaymentHelperConfig calldata config_) external override onlyProtocolAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the identifier of new chain id|
|`config_`|`PaymentHelperConfig`|is the chain config|


### updateChainConfig

*admin update remote chain config for estimation*


```solidity
function updateChainConfig(
    uint64 chainId_,
    uint256 configType_,
    bytes memory config_
)
    external
    override
    onlyEmergencyAdmin;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId_`|`uint64`|is the remote chain's identifier|
|`configType_`|`uint256`|is the type of config from 1 -> 6|
|`config_`|`bytes`|is the encoded new configuration|


### calculateAMBData

*Type 1: DST TOKEN PRICE FEED ORACLE*

*Type 2: DST GAS PRICE ORACLE*

*Type 3: PAYLOAD UPDATE GAS COST PER TX FOR DEPOSIT*

*Type 4: DEPOSIT GAS COST PER TX*

*Type 5: WITHDRAW GAS COST PER TX*

*Type 6: DEFAULT NATIVE PRICE*

*Type 7: DEFAULT GAS PRICE*

*Type 8: GAS PRICE PER KB of Message*

*Type 9: ACK GAS COST*

*Type 10: TWO STEP PROCESSING COST*

*Type 11: SWAP GAS USED*


```solidity
function calculateAMBData(
    uint64 dstChainId_,
    uint8[] calldata ambIds_,
    bytes memory message_
)
    external
    view
    override
    returns (uint256 totalFees, bytes memory extraData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dstChainId_`|`uint64`|is the unique dst chain identifier|
|`ambIds_`|`uint8[]`|is the identifiers of arbitrary message bridges to be used|
|`message_`|`bytes`|is the encoded cross-chain payload|


### estimateMultiDstMultiVault

*estimates the gas fees for multiple destination and multi vault operation*


```solidity
function estimateMultiDstMultiVault(
    MultiDstMultiVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateMultiDstSingleVault

optimistically estimating. (Ideal case scenario: no failed deposits / withdrawals)

*step 1: estimate amb costs*

*step 2: estimate update cost (only for deposit)*

*step 3: estimation processing cost of acknowledgement*

*step 4: estimate liq amount*

*step 5: estimate dst swap cost if it exists*

*step 6: estimate execution costs in dst (withdraw / deposit)
note: execution cost includes acknowledgement messaging cost*

*step 7: convert all dst gas estimates to src chain estimate  (withdraw / deposit)*


```solidity
function estimateMultiDstSingleVault(
    MultiDstSingleVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleXChainMultiVault

*step 1: estimate amb costs*

*step 2: estimate update cost (only for deposit)*

*step 3: estimation execution cost of acknowledgement*

*step 4: estimate the liqAmount*

*step 5: estimate if swap costs are involved*

*step 5: estimate execution costs in dst
note: execution cost includes acknowledgement messaging cost*

*step 6: convert all dst gas estimates to src chain estimate*


```solidity
function estimateSingleXChainMultiVault(
    SingleXChainMultiVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter    ///|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleXChainSingleVault

*step 1: estimate amb costs*

*step 2: estimate update cost (only for deposit)*

*step 3: estimate execution costs in dst
note: execution cost includes acknowledgement messaging cost*

*step 4: estimation execution cost of acknowledgement*

*step 5: estimate liq amount*

*step 6: estimate if swap costs are involved*

*step 7: convert all dst gas estimates to src chain estimate*


```solidity
function estimateSingleXChainSingleVault(
    SingleXChainSingleVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleDirectSingleVault

*step 1: estimate amb costs*

*step 2: estimate update cost (only for deposit)*

*step 3: estimate execution costs in dst
note: execution cost includes acknowledgement messaging cost*

*step 4: estimation execution cost of acknowledgement*

*step 5: estimate the liq amount*

*step 6: estimate if swap costs are involved*

*step 7: convert all dst gas estimates to src chain estimate*


```solidity
function estimateSingleDirectSingleVault(
    SingleDirectSingleVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateSingleDirectMultiVault

*only if timelock form withdrawal is involved*

*not adding dstAmount to save some GAS*


```solidity
function estimateSingleDirectMultiVault(
    SingleDirectMultiVaultStateReq calldata req_,
    bool isDeposit_
)
    external
    view
    override
    returns (uint256 liqAmount, uint256 srcAmount, uint256 dstAmount, uint256 totalAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectMultiVaultStateReq`|is the request object containing all necessary data for the actual operation on SuperRouter|
|`isDeposit_`|`bool`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liqAmount`|`uint256`|is the amount of liquidity to be provided in native tokens|
|`srcAmount`|`uint256`|is the gas expense on source chain in native tokens|
|`dstAmount`|`uint256`|is the gas expense on dst chain in terms of src chain's native tokens|
|`totalAmount`|`uint256`|is the native_tokens to be sent along the transaction|


### estimateAMBFees

*only if timelock form withdrawal is involved*

*not adding dstAmount to save some GAS*


```solidity
function estimateAMBFees(
    uint8[] memory ambIds_,
    uint64 dstChainId_,
    bytes memory message_,
    bytes[] memory extraData_
)
    public
    view
    returns (uint256 totalFees, uint256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ambIds_`|`uint8[]`|is the identifier of different AMBs|
|`dstChainId_`|`uint64`|is the identifier of the destination chain|
|`message_`|`bytes`|is the cross-chain message|
|`extraData_`|`bytes[]`|is any amb-specific information|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`totalFees`|`uint256`|ambFees is the native_tokens to be sent along the transaction for all the ambIds_ included|
|`<none>`|`uint256[]`||


### _generateExtraData

*just checks the estimate for sending message from src -> dst*

*helps generate extra data per amb*


```solidity
function _generateExtraData(
    uint64 dstChainId_,
    uint8[] calldata ambIds_,
    bytes memory message_
)
    public
    view
    returns (bytes[] memory extraDataPerAMB);
```

### _estimateAMBFees

*helps estimate the cross-chain message costs*


```solidity
function _estimateAMBFees(
    uint8[] calldata ambIds_,
    uint64 dstChainId_,
    bytes memory message_
)
    public
    view
    returns (uint256[] memory feeSplitUp, uint256 totalFees);
```

### _estimateAMBFeesReturnExtraData

*just checks the estimate for sending message from src -> dst*

*only ambIds_[0] = primary amb (rest of the ambs send only the proof)*

*helps estimate the cross-chain message costs*


```solidity
function _estimateAMBFeesReturnExtraData(
    uint64 dstChainId_,
    uint8[] calldata ambIds_,
    bytes memory message_
)
    public
    view
    returns (uint256[] memory feeSplitUp, bytes[] memory extraDataPerAMB, uint256 totalFees);
```

### _estimateLiqAmount

*just checks the estimate for sending message from src -> dst*

*helps estimate the liq amount involved in the tx*


```solidity
function _estimateLiqAmount(LiqRequest[] memory req_) internal view returns (uint256 liqAmount);
```

### _estimateSwapFees

*helps estimate the dst chain swap gas limit (if multi-tx is involved)*


```solidity
function _estimateSwapFees(uint64 dstChainId_, LiqRequest[] memory liqReq_) internal view returns (uint256 gasUsed);
```

### _estimateUpdateCost

*checks if tx_data receiver is dstSwapProcessor*

*helps estimate the dst chain update payload gas limit*


```solidity
function _estimateUpdateCost(uint64 dstChainId_, uint256 vaultsCount_) internal view returns (uint256 gasUsed);
```

### _estimateDstExecutionCost

*helps estimate the dst chain processing gas limit*


```solidity
function _estimateDstExecutionCost(
    bool isDeposit_,
    uint64 dstChainId_,
    uint256 vaultsCount_
)
    internal
    view
    returns (uint256 gasUsed);
```

### _estimateAckProcessingCost

*helps estimate the src chain processing fee*


```solidity
function _estimateAckProcessingCost(
    uint256 dstChainCount_,
    uint256 vaultsCount_
)
    internal
    view
    returns (uint256 nativeFee);
```

### _generateSingleVaultMessage

*generates the amb message for single vault data*


```solidity
function _generateSingleVaultMessage(SingleVaultSFData memory sfData_) internal view returns (bytes memory message_);
```

### _generateMultiVaultMessage

*sample router id for estimation*

*generates the amb message for multi vault data*


```solidity
function _generateMultiVaultMessage(MultiVaultSFData memory sfData_) internal view returns (bytes memory message_);
```

### _convertToNativeFee

*sample router id for estimation*

*helps convert the dst gas fee into src chain native fee*

*https://docs.soliditylang.org/en/v0.8.4/units-and-global-variables.html#ether-units*

*all native tokens should be 18 decimals across all EVMs*


```solidity
function _convertToNativeFee(uint64 dstChainId_, uint256 dstGas_) internal view returns (uint256 nativeFee);
```

### _getNextPayloadId

*gas fee * gas price (to get the gas amounts in dst chain's native token)*

*gas price is 9 decimal (in gwei)*

*assumption: all evm native tokens are 18 decimals*

*converts the gas to pay in terms of native token to usd value*

*native token price is 8 decimal*

*converts the usd value to source chain's native token*

*native token price is 8 decimal which cancels the 8 decimal multiplied in previous step*

*helps generate the new payload id*

*next payload id = current payload id + 1*


```solidity
function _getNextPayloadId() internal view returns (uint256 nextPayloadId);
```

### _getGasPrice

*helps return the current gas price of different networks*


```solidity
function _getGasPrice(uint64 chainId_) internal view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|native token price|


### _getNativeTokenPrice

*helps return the dst chain token price of different networks*


```solidity
function _getNativeTokenPrice(uint64 chainId_) internal view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|native token price|


