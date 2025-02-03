# SuperformRouter
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/SuperformRouter.sol)

**Inherits:**
[BaseRouterImplementation](/src/BaseRouterImplementation.sol/abstract.BaseRouterImplementation.md)

**Author:**
Zeropoint Labs.

SPDX-License-Identifier: Apache-2.0

*SuperformRouter users funds and action information to a remote execution chain.*

*Uses standard BaseRouterImplementation without any overrides to internal execution functions*


## Functions
### constructor


```solidity
constructor(
    address superRegistry_,
    uint8 stateRegistryType_,
    uint8 routerType_
)
    BaseRouterImplementation(superRegistry_, stateRegistryType_, routerType_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`superRegistry_`|`address`|the superform registry contract|
|`stateRegistryType_`|`uint8`|the state registry type|
|`routerType_`|`uint8`|the router type|


### multiDstMultiVaultDeposit

*Performs multi destination x multi vault deposits*


```solidity
function multiDstMultiVaultDeposit(MultiDstMultiVaultStateReq calldata req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstSingleVaultDeposit

*Performs multi destination x single vault deposits*


```solidity
function multiDstSingleVaultDeposit(MultiDstSingleVaultStateReq calldata req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainMultiVaultDeposit

*Performs single destination x multi vault deposits*


```solidity
function singleXChainMultiVaultDeposit(SingleXChainMultiVaultStateReq memory req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
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
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectMultiVaultDeposit

*Performs single direct x multi vault deposits*


```solidity
function singleDirectMultiVaultDeposit(SingleDirectMultiVaultStateReq memory req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
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
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstMultiVaultWithdraw

*Performs multi destination x multi vault withdraws*


```solidity
function multiDstMultiVaultWithdraw(MultiDstMultiVaultStateReq calldata req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstMultiVaultStateReq`|is the request object containing all the necessary data for the action|


### multiDstSingleVaultWithdraw

*Performs multi destination x single vault withdraws*


```solidity
function multiDstSingleVaultWithdraw(MultiDstSingleVaultStateReq calldata req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`MultiDstSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleXChainMultiVaultWithdraw

*Performs single destination x multi vault withdraws*


```solidity
function singleXChainMultiVaultWithdraw(SingleXChainMultiVaultStateReq memory req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
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
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleXChainSingleVaultStateReq`|is the request object containing all the necessary data for the action|


### singleDirectMultiVaultWithdraw

*Performs single direct x multi vault withdraws*


```solidity
function singleDirectMultiVaultWithdraw(SingleDirectMultiVaultStateReq memory req_)
    external
    payable
    override(BaseRouter, IBaseRouter);
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
    override(BaseRouter, IBaseRouter);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`req_`|`SingleDirectSingleVaultStateReq`|is the request object containing all the necessary data for the action|


