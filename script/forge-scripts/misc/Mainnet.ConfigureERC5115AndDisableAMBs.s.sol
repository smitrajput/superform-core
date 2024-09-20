// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import { AbstractConfigure5115FormAndDisableAMB } from "./Abstract.ConfigureERC5115AndDisableAMBs.s.sol";

contract MainnetConfigure5115FormAndDisableAMB is AbstractConfigure5115FormAndDisableAMB {
    function deployLayerzeroV1(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _deployLayerzeroV1(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function deployPaymentHelperV2(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _deployPaymentHelperV2(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function deployPayloadHelperV2(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _deployPayloadHelperV2(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function configureProdPayloadHelperv2(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _configureProdPayloadHelper(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function configureProdPaymentHelperViaPaymentAdmin(
        uint256 env,
        uint256 selectedChainIndex,
        uint256 useNewSalt
    )
        external
    {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _configurePaymentHelperViaPaymentAdmin(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function configureProdPaymentHelperViaPaymentAdminFantom(
        uint256 env,
        uint256 selectedChainIndex,
        uint256 useNewSalt
    )
        external
    {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _configurePaymentHelperViaPaymentAdminFantom(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function configure5115AndDisableAMB(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _configureERC5115AndDisableOldAMBs(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }

    function configureProdPaymentAdmin(uint256 env, uint256 selectedChainIndex, uint256 useNewSalt) external {
        _setEnvironment(env, useNewSalt == 1 ? true : false);
        _preDeploymentSetup();

        uint256 trueIndex;
        for (uint256 i = 0; i < chainIds.length; i++) {
            if (TARGET_CHAINS[selectedChainIndex] == chainIds[i]) {
                trueIndex = i;
                break;
            }
        }

        _configureProdPaymentAdmin(env, selectedChainIndex, trueIndex, Cycle.Prod, TARGET_CHAINS);
    }
}
