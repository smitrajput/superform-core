# BaseRouter
[Git Source](https://github.com/smitrajput/superform-core/blob/f7efd6b9ccfacf8dcd49a7bfa74cda4b4a1c5fdf/src/BaseRouter.sol)

**Inherits:**
[IBaseRouter](/src/interfaces/IBaseRouter.sol/interface.IBaseRouter.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*Routes users funds and action information to a remote execution chain.*

*abstract implementation that allows inheriting routers to implement their own logic*


## State Variables
### STATE_REGISTRY_TYPE

```solidity
uint8 public immutable STATE_REGISTRY_TYPE;
```


### ROUTER_TYPE

```solidity
uint8 public immutable ROUTER_TYPE;
```


### CHAIN_ID

```solidity
uint64 public immutable CHAIN_ID;
```


### superRegistry

```solidity
ISuperRegistry public immutable superRegistry;
```


## Functions
### constructor


```solidity
constructor(address superRegistry_, uint8 stateRegistryType_, uint8 routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|
|`stateRegistryType_`|`uint8`|the state registry type|
|`routerType_`|`uint8`|the router type|


### receive

receive enables processing native token transfers into the smart contract.

liquidity bridge fails without a native receive function.


```solidity
receive() external payable;
```

### multiDstMultiVaultDeposit

*Performs multi destination x multi vault deposits*


```solidity
function multiDstMultiVaultDeposit(MultiDstMultiVaultStateReq calldata req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstSingleVaultDeposit

*Performs multi destination x single vault deposits*


```solidity
function multiDstSingleVaultDeposit(MultiDstSingleVaultStateReq calldata req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainMultiVaultDeposit

*Performs single destination x multi vault deposits*


```solidity
function singleXChainMultiVaultDeposit(SingleXChainMultiVaultStateReq memory req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainSingleVaultDeposit

*Performs single xchain destination x single vault deposits*


```solidity
function singleXChainSingleVaultDeposit(SingleXChainSingleVaultStateReq memory req_)
    external
    payable
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectMultiVaultDeposit

*Performs single direct x multi vault deposits*


```solidity
function singleDirectMultiVaultDeposit(SingleDirectMultiVaultStateReq memory req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectSingleVaultDeposit

*Performs single direct x single vault deposits*


```solidity
function singleDirectSingleVaultDeposit(SingleDirectSingleVaultStateReq memory req_)
    external
    payable
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstMultiVaultWithdraw

*Performs multi destination x multi vault withdraws*


```solidity
function multiDstMultiVaultWithdraw(MultiDstMultiVaultStateReq calldata req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstSingleVaultWithdraw

*Performs multi destination x single vault withdraws*


```solidity
function multiDstSingleVaultWithdraw(MultiDstSingleVaultStateReq calldata req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainMultiVaultWithdraw

*Performs single destination x multi vault withdraws*


```solidity
function singleXChainMultiVaultWithdraw(SingleXChainMultiVaultStateReq memory req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainSingleVaultWithdraw

*Performs single xchain destination x single vault withdraws*


```solidity
function singleXChainSingleVaultWithdraw(SingleXChainSingleVaultStateReq memory req_)
    external
    payable
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectMultiVaultWithdraw

*Performs single direct x multi vault withdraws*


```solidity
function singleDirectMultiVaultWithdraw(SingleDirectMultiVaultStateReq memory req_) external payable virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectSingleVaultWithdraw

*Performs single direct x single vault withdraws*


```solidity
function singleDirectSingleVaultWithdraw(SingleDirectSingleVaultStateReq memory req_)
    external
    payable
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all the necessary data for the action|


