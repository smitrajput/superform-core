// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import { Error } from "src/libraries/Error.sol";
import { MockERC20 } from "test/mocks/MockERC20.sol";
import { VaultMock } from "test/mocks/VaultMock.sol";
import { Strings } from "openzeppelin-contracts/contracts/utils/Strings.sol";
import "test/utils/ProtocolActions.sol";
import { DataLib } from "src/libraries/DataLib.sol";
import { SuperformRouter } from "src/SuperformRouter.sol";
import { SuperPositions } from "src/SuperPositions.sol";
import { IBaseForm } from "src/interfaces/IBaseForm.sol";
import "src/types/DataTypes.sol";

contract ForwardDustFormTest is ProtocolActions {
    uint64 internal chainId = ETH;
    address receiverAddress = address(444);

    function setUp() public override {
        super.setUp();
    }

    function test_forwardDustToPaymaster() public {
        address superform = _successfulDepositWithdraw("VaultMock", 0, 1e18, 0, true, deployer);

        uint256 balanceBefore = MockERC20(getContract(ARBI, "WETH")).balanceOf(superform);
        assertGt(balanceBefore, 0);
        IBaseForm(superform).forwardDustToPaymaster(getContract(ARBI, "WETH"));
        uint256 balanceAfter = MockERC20(getContract(ARBI, "WETH")).balanceOf(superform);

        assertEq(balanceAfter, 0);
    }

    function test_forwardDustToPaymasterNoDust() public {
        address superform = _successfulDepositWithdraw("VaultMock", 0, 1e18, 0, false, deployer);

        uint256 balanceBefore = MockERC20(getContract(ARBI, "WETH")).balanceOf(superform);
        assertEq(balanceBefore, 0);
        IBaseForm(superform).forwardDustToPaymaster(getContract(ARBI, "WETH"));
        uint256 balanceAfter = MockERC20(getContract(ARBI, "WETH")).balanceOf(superform);

        assertEq(balanceAfter, 0);
    }

    function test_forwardDustToPaymaster_arbitraryToken_4626revert() public {
        address superform = _successfulDepositWithdraw("VaultMock", 0, 1e18, 0, false, deployer);

        address arbitraryToken = getContract(ARBI, "DAI");
        deal(arbitraryToken, superform, 10e18);

        IBaseForm(superform).forwardDustToPaymaster(arbitraryToken);
        address vaultAddress = IBaseForm(superform).getVaultAddress();
        vm.expectRevert(Error.CANNOT_FORWARD_4646_TOKEN.selector);
        IBaseForm(superform).forwardDustToPaymaster(vaultAddress);

        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        IBaseForm(superform).forwardDustToPaymaster(address(0));
    }

    function _successfulDepositWithdraw(
        string memory vaultKind_,
        uint256 formImplementationId_,
        uint256 amountToDeposit_,
        uint256 spAmountToRedeem_, // set to 0 for full withdraw
        bool nasty_,
        address user
    )
        internal
        returns (address superform)
    {
        /// @dev prank deposits (just mint super-shares)
        /// scenario: user deposits with his own token and has approved enough tokens
        vm.selectFork(FORKS[ARBI]);
        vm.startPrank(user);

        superform = getContract(
            ARBI,
            string.concat(
                "WETH", vaultKind_, "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[formImplementationId_])
            )
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[formImplementationId_], ARBI);

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            amountToDeposit_,
            IBaseForm(superform).previewDepositTo(amountToDeposit_),
            100,
            LiqRequest("", getContract(ARBI, "WETH"), address(0), 1, ARBI, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ARBI, "SuperformRouter");

        /// @dev approves before call
        MockERC20(getContract(ARBI, "WETH")).approve(router, amountToDeposit_);
        SuperformRouter(payable(router)).singleDirectSingleVaultDeposit(req);

        IBaseForm(superform).getVaultAddress();

        vm.stopPrank();

        uint256 superPositionBalance =
            SuperPositions(getContract(ARBI, "SuperPositions")).balanceOf(receiverAddress, superformId);

        InitSingleVaultData memory data2 = InitSingleVaultData(
            1,
            superformId,
            spAmountToRedeem_ == 0 ? superPositionBalance : spAmountToRedeem_,
            spAmountToRedeem_ == 0 ? superPositionBalance : spAmountToRedeem_,
            100,
            LiqRequest(
                _buildDummyTxDataUnitTests(
                    BuildDummyTxDataUnitTestsVars(
                        1,
                        getContract(ARBI, "WETH"),
                        getContract(ETH, "WETH"),
                        superform,
                        ARBI,
                        ETH,
                        nasty_ ? 0.99e18 : IBaseForm(superform).previewRedeemFrom(superPositionBalance), // nastiness
                            // here
                        receiverAddress,
                        false
                    )
                ),
                getContract(ETH, "WETH"),
                address(0),
                1,
                ETH,
                0
            ),
            false,
            false,
            receiverAddress,
            ""
        );
        vm.selectFork(FORKS[ARBI]);

        if (formImplementationId_ != 1) {
            vm.prank(getContract(ARBI, "CoreStateRegistry"));
            IBaseForm(superform).xChainWithdrawFromVault(data2, user, ETH);
        }
    }
}
