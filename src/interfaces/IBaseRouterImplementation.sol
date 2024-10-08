// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

import { IBaseRouter } from "./IBaseRouter.sol";

import "../types/DataTypes.sol";

/// @title IBaseRouterImplementation
/// @author Zeropoint Labs.
/// @dev interface for BaseRouterImplementation
interface IBaseRouterImplementation is IBaseRouter {
    /*///////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    /// @dev For local memory variable loading and avoiding stack too deep errors
    struct ActionLocalVars {
        AMBMessage ambMessage;
        LiqRequest liqRequest;
        uint64 srcChainId;
        uint256 currentPayloadId;
        uint256 liqRequestsLen;
    }

    struct DispatchAMBMessageVars {
        TransactionType txType;
        bytes ambData;
        uint256[] superformIds;
        address srcSender;
        uint8[] ambIds;
        uint8 multiVaults;
        uint64 srcChainId;
        uint64 dstChainId;
        uint256 currentPayloadId;
    }

    /*///////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @dev is emitted when a cross-chain transaction is initiated.
    event CrossChainInitiated(uint256 indexed payloadId);

    /// @dev is emitted when a cross-chain transaction is completed.
    event Completed(uint256 payloadId);
}
