/// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// Test Utils
import "../../../utils/ProtocolActions.sol";

contract SDiMVW0000TokenInputNoSlippage2AMB23 is ProtocolActions {
    function setUp() public override {
        super.setUp();
        /*//////////////////////////////////////////////////////////////
                !! WARNING !!  DEFINE TEST SETTINGS HERE
    //////////////////////////////////////////////////////////////*/
        /// @dev singleDestinationMultiVault, large test

        AMBs = [3, 2];

        CHAIN_0 = ARBI;
        DST_CHAINS = [ARBI];

        /// @dev 3 vaults normal deposit equal, 1 normal
        TARGET_UNDERLYINGS[ARBI][0] = [1, 2, 0, 0];
        TARGET_VAULTS[ARBI][0] = [0, 0, 0, 2];
        TARGET_FORM_KINDS[ARBI][0] = [0, 0, 0, 2];

        TARGET_UNDERLYINGS[ARBI][1] = [1, 2, 0, 0];
        TARGET_VAULTS[ARBI][1] = [0, 0, 0, 2];
        TARGET_FORM_KINDS[ARBI][1] = [0, 0, 0, 2];

        MAX_SLIPPAGE = 1000;

        LIQ_BRIDGES[ARBI][0] = [1, 1, 1, 1];
        LIQ_BRIDGES[ARBI][1] = [1, 1, 1, 1];

        FINAL_LIQ_DST_WITHDRAW[ARBI] = [ARBI, ARBI, ARBI, ARBI];

        /// @dev push in order the actions should be executed
        actions.push(
            TestAction({
                action: Actions.Deposit,
                multiVaults: true, //!!WARNING turn on or off multi vaults
                user: 1,
                testType: TestType.Pass,
                revertError: "",
                revertRole: "",
                slippage: 0, // 0% <- if we are testing a pass this must be below each maxSlippage,
                dstSwap: false,
                externalToken: 2 // 0 = DAI, 1 = USDT, 2 = WETH
             })
        );

        actions.push(
            TestAction({
                action: Actions.Withdraw,
                multiVaults: true, //!!WARNING turn on or off multi vaults
                user: 1,
                testType: TestType.Pass,
                revertError: "",
                revertRole: "",
                slippage: 0, // 0% <- if we are testing a pass this must be below each maxSlippage,
                dstSwap: false,
                externalToken: 0 // 0 = DAI, 1 = USDT, 2 = WETH
             })
        );
    }

    /*///////////////////////////////////////////////////////////////
                        SCENARIO TESTS
    //////////////////////////////////////////////////////////////*/

    function test_scenario(uint128 amountOne_, uint128 amountTwo_, uint128 amountThree_, uint128 amountFour_) public {
        amountOne_ = uint128(bound(amountOne_, 2e18, 20e18));
        amountTwo_ = uint128(bound(amountTwo_, 2e18, 20e18));
        amountThree_ = uint128(bound(amountThree_, 2e18, 20e18));
        amountFour_ = uint128(bound(amountFour_, 2e18, 20e18));
        AMOUNTS[ARBI][0] = [amountOne_, amountTwo_, amountThree_, amountFour_];

        for (uint256 act = 0; act < actions.length; act++) {
            TestAction memory action = actions[act];
            MultiVaultSFData[] memory multiSuperformsData;
            SingleVaultSFData[] memory singleSuperformsData;
            MessagingAssertVars[] memory aV;
            StagesLocalVars memory vars;
            bool success;

            if (act == 1) {
                for (uint256 i = 0; i < DST_CHAINS.length; i++) {
                    /// @dev original super position amounts
                    uint256[] memory superPositions = _getSuperpositionsForDstChain(
                        actions[1].user,
                        TARGET_UNDERLYINGS[DST_CHAINS[i]][1],
                        TARGET_VAULTS[DST_CHAINS[i]][1],
                        TARGET_FORM_KINDS[DST_CHAINS[i]][1],
                        DST_CHAINS[i]
                    );

                    AMOUNTS[DST_CHAINS[i]][1] =
                        [superPositions[0], superPositions[1], superPositions[2], superPositions[3]];
                }
            }

            _runMainStages(action, act, multiSuperformsData, singleSuperformsData, aV, vars, success);
        }
    }
}
