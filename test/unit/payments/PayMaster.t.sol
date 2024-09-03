// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import { ERC1155Holder } from "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import { OneInchMock } from "test/mocks/OneInchMock.sol";
import { IAggregationRouterV6, IERC20 } from "src/vendor/1inch/IAggregationRouterV6.sol";
import { Error } from "src/libraries/Error.sol";
import {
    ProtocolActions,
    SuperRegistry,
    PayMaster,
    LiqRequest,
    AMBMessage,
    BroadCastAMBExtraData,
    SingleVaultSFData,
    DataLib,
    Strings,
    HyperlaneImplementation,
    SingleDirectSingleVaultStateReq,
    MockERC20,
    PaymentHelper,
    SuperformRouter
} from "test/utils/ProtocolActions.sol";

contract KeeperMock is ERC1155Holder {
    receive() external payable { }
}

contract KeeperMockThatWontAcceptEth is ERC1155Holder {
    receive() external payable {
        revert();
    }
}

contract PayMasterTest is ProtocolActions {
    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address txProcessorETH;
    address txUpdaterETH;
    address txProcessorARBI;
    address txUpdaterARBI;

    address receiverAddress = address(444);

    SuperRegistry superRegistry;
    SuperRegistry superRegistryARBI;

    function setUp() public override {
        super.setUp();

        vm.selectFork(FORKS[ETH]);

        txProcessorETH = address(new KeeperMock());
        txUpdaterETH = address(new KeeperMock());

        superRegistry = SuperRegistry(getContract(ETH, "SuperRegistry"));

        vm.selectFork(FORKS[ARBI]);
        txProcessorARBI = address(new KeeperMock());
        txUpdaterARBI = address(new KeeperMock());

        vm.selectFork(FORKS[ETH]);

        /// @dev setting these here as overrides just to test with receive function
        vm.startPrank(deployer);
        superRegistry.setAddress(keccak256("CORE_REGISTRY_PROCESSOR"), txProcessorARBI, ARBI);
        superRegistry.setAddress(keccak256("CORE_REGISTRY_UPDATER"), txUpdaterARBI, ARBI);
        vm.stopPrank();
    }

    function test_manipulationsBySendingFeesIntoRouter() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        /// @dev at this point the contract has 1 ether extra
        address superformRouter = getContract(ETH, "SuperformRouter");
        payable(superformRouter).transfer(1 ether);

        /// @dev make a deposit and send in 2 ether extra for other off-chain operations
        _successfulDeposit();
        assertEq(address(superformRouter).balance, 1 ether);
        assertEq(getContract(ETH, "PayMaster").balance, 2 ether);
    }

    function test_validationsInMakePayment() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        /// @dev make zero payment
        vm.expectRevert(Error.FAILED_TO_SEND_NATIVE.selector);
        PayMaster(payable(getContract(ETH, "PayMaster"))).makePayment(deployer);

        /// @dev try to make payment for zero address
        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(getContract(ETH, "PayMaster"))).makePayment{ value: 1 wei }(address(0));
    }

    function test_withdrawNativeToTx_notPrivileged() public {
        vm.selectFork(FORKS[ETH]);
        vm.prank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");

        /// @dev makes payment of 1 wei
        PayMaster(payable(feeCollector)).makePayment{ value: 1 wei }(deployer);
        assertEq(feeCollector.balance, 1 wei);

        vm.startPrank(address(0x8282));
        /// @dev admin tries withdraw more than balance (check if handled gracefully)
        vm.expectRevert(Error.NOT_PAYMENT_ADMIN.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_PROCESSOR"), 2 wei);

        vm.expectRevert(Error.NOT_PAYMENT_ADMIN.selector);
        PayMaster(payable(feeCollector)).withdrawTo(keccak256("CORE_REGISTRY_PROCESSOR"), address(0), 2 wei);

        LiqRequest memory r;
        vm.expectRevert(Error.NOT_PAYMENT_ADMIN.selector);
        PayMaster(payable(feeCollector)).rebalanceTo(keccak256("CORE_REGISTRY_PROCESSOR"), r, 1);

        vm.expectRevert(Error.NOT_PAYMENT_ADMIN.selector);
        PayMaster(payable(feeCollector)).treatAMB(1, 1, "");
    }

    function test_withdrawNativeToTxProcessor() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");

        /// @dev makes payment of 1 wei
        PayMaster(payable(feeCollector)).makePayment{ value: 1 wei }(deployer);
        assertEq(feeCollector.balance, 1 wei);

        /// @dev admin tries withdraw more than balance (check if handled gracefully)
        vm.expectRevert(Error.FAILED_TO_SEND_NATIVE.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_PROCESSOR"), 2 wei);

        /// @dev admin tries withdraw if processor address is zero (check if handled gracefully)
        superRegistry.setAddress(keccak256("CORE_REGISTRY_PROCESSOR"), address(0), ETH);

        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_PROCESSOR"), 1 wei);

        superRegistry.setAddress(keccak256("CORE_REGISTRY_PROCESSOR"), txProcessorETH, ETH);

        uint256 balanceBefore = txProcessorETH.balance;
        /// @dev admin moves the payment from fee collector to tx processor
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_PROCESSOR"), 1 wei);
        assertEq(feeCollector.balance, 0);
        assertEq(txProcessorETH.balance - balanceBefore, 1 wei);
    }

    function test_withdrawNativeToSuperformReceiver() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");
        address token = getContract(ETH, "DAI");
        /// @dev transfer 10 dai to paymaster
        deal(token, feeCollector, 10e18);

        /// @dev admin tries withdraw 0
        vm.expectRevert(Error.ZERO_INPUT_VALUE.selector);
        PayMaster(payable(feeCollector)).withdrawTo(keccak256("SUPERFORM_RECEIVER"), token, 0);

        /// @dev admin tries withdraw token address 0
        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(feeCollector)).withdrawTo(keccak256("SUPERFORM_RECEIVER"), address(0), 10e18);

        /// @dev admin tries withdraw token  above balance
        vm.expectRevert(Error.INSUFFICIENT_BALANCE.selector);
        PayMaster(payable(feeCollector)).withdrawTo(keccak256("SUPERFORM_RECEIVER"), token, 11e18);

        /// @dev admin tries withdraw
        PayMaster(payable(feeCollector)).withdrawTo(keccak256("SUPERFORM_RECEIVER"), token, 10e18);
    }

    function test_withdrawNativeToTxUpdater() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");

        /// @dev makes payment of 1 wei
        PayMaster(payable(feeCollector)).makePayment{ value: 1 wei }(deployer);
        assertEq(feeCollector.balance, 1 wei);

        /// @dev admin tries withdraw more than balance (check if handled gracefully)
        vm.expectRevert(Error.FAILED_TO_SEND_NATIVE.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_UPDATER"), 2 wei);

        /// @dev admin tries withdraw if updater address is zero (check if handled gracefully)
        superRegistry.setAddress(keccak256("CORE_REGISTRY_UPDATER"), address(0), ETH);

        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_UPDATER"), 1 wei);

        superRegistry.setAddress(keccak256("CORE_REGISTRY_UPDATER"), txUpdaterETH, ETH);

        /// @dev admin moves the payment from fee collector to tx updater
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("CORE_REGISTRY_UPDATER"), 1 wei);
        assertEq(feeCollector.balance, 0);
        assertEq(txUpdaterETH.balance, 1 wei);
    }

    function test_withdrawNativeToFailure() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");
        PayMaster(payable(feeCollector)).makePayment{ value: 2 wei }(deployer);

        address mock = address(new KeeperMockThatWontAcceptEth());

        superRegistry.setAddress(keccak256("KEEPER_MOCK"), mock, ETH);

        /// @dev admin tries withdraw more than balance (check if handled gracefully)
        vm.expectRevert(Error.FAILED_TO_SEND_NATIVE.selector);
        PayMaster(payable(feeCollector)).withdrawNativeTo(keccak256("KEEPER_MOCK"), 1 wei);
    }

    function test_rebalanceToCoreStateRegistryTxProcessor() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");
        address feeCollectorDst = getContract(ARBI, "PayMaster");

        /// @dev makes payment of 1 ether
        PayMaster(payable(feeCollector)).makePayment{ value: 1 ether }(deployer);
        assertEq(feeCollector.balance, 1 ether);

        /// @dev admin tries withdraw if processor address is zero (check if handled gracefully)
        superRegistry.setAddress(keccak256("CORE_REGISTRY_PROCESSOR"), address(0), ETH);

        bytes memory txData = _buildDummyTxDataUnitTests(
            BuildDummyTxDataUnitTestsVars(1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, feeCollectorDst, false)
        );

        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_PROCESSOR"), LiqRequest(txData, NATIVE, address(0), 1, ARBI, 1 ether), 420
        );

        superRegistry.setAddress(keccak256("CORE_REGISTRY_PROCESSOR"), txProcessorETH, ETH);
        txData = _buildDummyTxDataUnitTests(
            BuildDummyTxDataUnitTestsVars(1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, feeCollectorDst, false)
        );
        /// @dev admin moves the payment from fee collector to different address on another chain
        vm.expectRevert(Error.INVALID_TXDATA_RECEIVER.selector);
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_PROCESSOR"), LiqRequest(txData, NATIVE, address(0), 1, ARBI, 1 ether), ARBI
        );
        txData = _buildDummyTxDataUnitTests(
            BuildDummyTxDataUnitTestsVars(1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, txProcessorARBI, false)
        );

        /// @dev admin moves the payment from fee collector (ideal conditions)
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_PROCESSOR"),
            LiqRequest(
                _buildDummyTxDataUnitTests(
                    BuildDummyTxDataUnitTestsVars(
                        1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, txProcessorARBI, false
                    )
                ),
                NATIVE,
                address(0),
                1,
                ARBI,
                1 ether
            ),
            ARBI
        );

        assertEq(feeCollector.balance, 0);

        vm.selectFork(FORKS[ARBI]);
        /// @dev amount received will be bridge-slippage-adjusted
        assertEq(
            txProcessorARBI.balance,
            _updateAmountWithPricedSwapsAndSlippage(1 ether, totalSlippage, NATIVE, NATIVE, NATIVE, ETH, ARBI)
        );
    }

    function test_rebalanceToCoreStateRegistryTxUpdater() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");
        address feeCollectorDst = getContract(ARBI, "PayMaster");

        /// @dev makes payment of 1 ether
        PayMaster(payable(feeCollector)).makePayment{ value: 1 ether }(deployer);
        assertEq(feeCollector.balance, 1 ether);

        /// @dev admin tries withdraw if processor address is zero (check if handled gracefully)
        superRegistry.setAddress(keccak256("CORE_REGISTRY_UPDATER"), address(0), ETH);
        bytes memory txData = _buildDummyTxDataUnitTests(
            BuildDummyTxDataUnitTestsVars(1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, feeCollectorDst, false)
        );

        vm.expectRevert(Error.ZERO_ADDRESS.selector);
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_UPDATER"), LiqRequest(txData, NATIVE, address(0), 1, ARBI, 1 ether), 420
        );

        superRegistry.setAddress(keccak256("CORE_REGISTRY_UPDATER"), txUpdaterARBI, ETH);

        txData = _buildDummyTxDataUnitTests(
            BuildDummyTxDataUnitTestsVars(1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, feeCollectorDst, false)
        );

        /// @dev admin moves the payment from fee collector to different address on another chain
        vm.expectRevert(Error.INVALID_TXDATA_RECEIVER.selector);
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_UPDATER"), LiqRequest(txData, NATIVE, address(0), 1, ARBI, 1 ether), ARBI
        );

        /// @dev admin moves the payment from fee collector (ideal conditions)
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_REGISTRY_UPDATER"),
            LiqRequest(
                _buildDummyTxDataUnitTests(
                    BuildDummyTxDataUnitTestsVars(
                        1, NATIVE, NATIVE, feeCollector, ETH, ARBI, 1 ether, txUpdaterARBI, false
                    )
                ),
                NATIVE,
                address(0),
                1,
                ARBI,
                1 ether
            ),
            ARBI
        );

        assertEq(feeCollector.balance, 0);

        vm.selectFork(FORKS[ARBI]);
        /// @dev amount received will be bridge-slippage-adjusted
        assertEq(
            txUpdaterARBI.balance,
            _updateAmountWithPricedSwapsAndSlippage(1 ether, totalSlippage, NATIVE, NATIVE, NATIVE, ETH, ARBI)
        );
    }

    function test_rebalanceTo_usingOneInch() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address feeCollector = getContract(ETH, "PayMaster");
        address receiver = getContract(ETH, "CoreStateRegistry");
        address usdc = getContract(ETH, "USDC");

        PayMaster(payable(feeCollector)).makePayment{ value: 1 ether }(deployer);

        /// @dev should always use only the `swap` selector
        bytes memory txData = abi.encodeWithSelector(
            OneInchMock.swap.selector,
            address(0),
            IAggregationRouterV6.SwapDescription(
                IERC20(NATIVE), IERC20(usdc), payable(receiver), payable(receiver), 1 ether, 4000 * 1e6, 0
            ),
            bytes("")
        );
        PayMaster(payable(feeCollector)).rebalanceTo(
            keccak256("CORE_STATE_REGISTRY"), LiqRequest(txData, NATIVE, address(0), 9, ARBI, 1 ether), ETH
        );
        assertEq(IERC20(usdc).balanceOf(receiver), 4000 * 1e6);
    }

    function test_treatAMB() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);
        address feeCollector = getContract(ETH, "PayMaster");
        vm.expectRevert(Error.FAILED_TO_SEND_NATIVE.selector);
        PayMaster(payable(feeCollector)).treatAMB(2, 10 ether, "");

        AMBMessage memory ambMessage;
        BroadCastAMBExtraData memory ambExtraData;
        address coreStateRegistry;
        address hyperlane = superRegistry.getAmbAddress(2);

        (ambMessage, ambExtraData, coreStateRegistry) = setupBroadcastPayloadAMBData(users[0], hyperlane);
        vm.stopPrank();
        vm.deal(getContract(ETH, "CoreStateRegistry"), 100 ether);
        vm.prank(getContract(ETH, "CoreStateRegistry"));
        HyperlaneImplementation(hyperlane).dispatchPayload{ value: 0.1 ether }(
            users[0], chainIds[5], abi.encode(ambMessage), abi.encode(ambExtraData)
        );
        uint32 destination = 10;
        bytes32 messageId = 0x024a45f20750393b28c9aac33aafc694857b6d09e9da4a8ed9f2b0e144685348;

        bytes memory data = abi.encode(messageId, destination, 1_500_000);

        uint256 fees = HyperlaneImplementation(hyperlane).igp().quoteGasPayment(destination, 1_500_000);

        vm.prank(deployer);
        vm.deal(feeCollector, 10 ether);
        PayMaster(payable(feeCollector)).treatAMB(2, fees, data);
    }

    function _successfulDeposit() internal {
        /// scenario: user deposits with his own token and has approved enough tokens
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest(bytes(""), getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            bytes(""),
            false,
            false,
            receiverAddress,
            receiverAddress,
            bytes("")
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        /// @dev approves before call
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);
        (,, uint256 msgFees) =
            PaymentHelper(getContract(ETH, "PaymentHelper")).estimateSingleDirectSingleVault(req, true);
        msgFees = msgFees + 2 ether;

        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit{ value: msgFees }(
            req
        );
    }
}
