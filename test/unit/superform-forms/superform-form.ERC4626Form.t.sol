// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import { Error } from "src/libraries/Error.sol";
import { ERC4626Form } from "src/forms/ERC4626Form.sol";
import { MockERC20 } from "test/mocks/MockERC20.sol";
import { VaultMock } from "test/mocks/VaultMock.sol";
import { VaultMockFailedDeposit } from "test/mocks/VaultMockFailedDeposit.sol";
import { VaultMockFailedWithdraw } from "test/mocks/VaultMockFailedWithdraw.sol";
import { SuperformFactory, ISuperformFactory } from "src/SuperformFactory.sol";
import { Strings } from "openzeppelin-contracts/contracts/utils/Strings.sol";
import "test/utils/ProtocolActions.sol";
import { DataLib } from "src/libraries/DataLib.sol";
import { SuperformRouter } from "src/SuperformRouter.sol";
import { SuperPositions } from "src/SuperPositions.sol";
import { IBaseForm } from "src/interfaces/IBaseForm.sol";
import { ILiFi } from "src/vendor/lifi/ILiFi.sol";
import { LibSwap } from "src/vendor/lifi/LibSwap.sol";
import { LiFiMock } from "test/mocks/LiFiMock.sol";
import "src/types/DataTypes.sol";

contract SuperformERC4626FormTest is ProtocolActions {
    uint64 internal chainId = ETH;
    address receiverAddress = address(444);

    function setUp() public override {
        super.setUp();
    }

    /// @dev Test Vault Symbol
    function test_superformVaultSymbol() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        string memory symbol = ERC4626Form(payable(superformCreated)).getVaultSymbol();

        assertEq(symbol, "Mock");
    }

    /// @dev Test Yield Token Symbol
    function test_superformYieldTokenSymbol() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        string memory symbol = ERC4626Form(payable(superformCreated)).superformYieldTokenSymbol();

        assertEq(symbol, "sp-Mock");
    }

    function test_superformVaultSharesAmountToUnderlyingAmount() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 assets = 10;
        uint256 withdrawableAssets = ERC4626Form(payable(superformCreated)).previewWithdrawFrom(assets);

        assertEq(assets, withdrawableAssets);
    }

    function test_superformVaultPreviewPricePerVaultShare() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 withdrawableAssets = ERC4626Form(payable(superformCreated)).getPreviewPricePerVaultShare();

        assertEq(withdrawableAssets, 1_000_000_000_000_000_000);
    }

    function test_superformVaultTotalAssets() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 totalAssets = ERC4626Form(payable(superformCreated)).getTotalAssets();

        assertEq(totalAssets, 0);
    }

    function test_superformVaultTotalSupply() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 totalSupply = ERC4626Form(payable(superformCreated)).getTotalSupply();

        assertEq(totalSupply, 0);
    }

    function test_superformVaultShareBalance() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 vaultShareBalance = ERC4626Form(payable(superformCreated)).getVaultShareBalance();

        assertEq(vaultShareBalance, 0);
    }

    function test_superformVaultPricePerVaultShare() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 priceVaultShare = ERC4626Form(payable(superformCreated)).getPricePerVaultShare();

        assertEq(priceVaultShare, 1_000_000_000_000_000_000);
    }

    function test_superformVaultDecimals() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        uint256 vaultDecimals = ERC4626Form(payable(superformCreated)).getVaultDecimals();

        assertEq(vaultDecimals, 18);
    }

    function test_superformVaultName() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        string memory vaultName = ERC4626Form(payable(superformCreated)).getVaultName();

        assertEq(vaultName, "Mock Vault");
    }

    function test_superformYieldTokenName() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );

        /// @dev Creating superform using formImplementationId and vault
        (, address superformCreated) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        string memory tokenName = ERC4626Form(payable(superformCreated)).superformYieldTokenName();

        assertEq(tokenName, "Mock Vault SuperPosition");
    }

    function test_superformDirectDepositWithoutAllowance() public {
        /// scenario: user deposits with his own token but failed to approve
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        /// @dev no approval before call
        vm.expectRevert(Error.INSUFFICIENT_ALLOWANCE_FOR_DEPOSIT.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);
    }

    function test_superformDirectDepositWithAllowance() public {
        _successfulDeposit(false);
    }

    function test_superformDirectDepositWithAllowance_retain4626() public {
        _successfulDeposit(true);
    }

    function test_superformDirectDepositWithoutEnoughAllowanceWithTokensForceSent() public {
        /// scenario: user deposits by utilizing any crude asset available in the form proxy
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);
        /// try depositing without approval
        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            2e18,
            2e18,
            100,
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        /// @dev make sure the form proxy has enough usdc for the user to hack it
        MockERC20(getContract(ETH, "DAI")).transfer(superform, 3e18);
        MockERC20(getContract(ETH, "DAI")).approve(superform, 1e18);

        vm.expectRevert(Error.INSUFFICIENT_ALLOWANCE_FOR_DEPOSIT.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);
    }

    function test_superformDirectDepositWithMaliciousTxData() public {
        /// scenario: user deposits by utilizing any crude asset available in the form proxy
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);
        /// try depositing without approval
        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        /// @dev txData with 1e18 input amount
        LiqBridgeTxDataArgs memory liqBridgeTxDataArgs = LiqBridgeTxDataArgs(
            1,
            getContract(ETH, "DAI"),
            getContract(ETH, "DAI"),
            getContract(ETH, "DAI"),
            superform,
            ETH,
            ETH,
            ETH,
            false,
            superform,
            uint256(ETH),
            1e18,
            //1e18,
            false,
            0,
            1,
            1,
            1,
            address(0)
        );

        /// @dev superform data with 2e18 final amount
        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            2e18,
            2e18,
            100,
            LiqRequest(_buildLiqBridgeTxData(liqBridgeTxDataArgs, true), getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        /// @dev make sure the form proxy has enough usdc for the user to hack it
        MockERC20(getContract(ETH, "DAI")).transfer(superform, 3e18);
        /// balanceBefore = 3e18
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);

        vm.expectRevert(Error.DIRECT_DEPOSIT_SWAP_FAILED.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);
    }

    function test_superformDirectDepositVaultImplementationFailed() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        VaultMockFailedDeposit vault = new VaultMockFailedDeposit(IERC20(getContract(ETH, "DAI")), "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );
        /// @dev Creating superform using formImplementationId and failed deposit vault
        (uint256 superformId,) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        /// @dev superform data with 1e18 final amount
        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);

        vm.expectRevert(Error.VAULT_IMPLEMENTATION_FAILED.selector);
        SuperformRouter(payable(router)).singleDirectSingleVaultDeposit(req);
    }

    function test_superformDirectWithdrawalWithMaliciousTxData() public {
        _successfulDeposit(false);

        /// scenario: user could hack the funds from the form
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(receiverAddress);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        address DAI = getContract(ETH, "DAI");
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            SuperPositions(getContract(ETH, "SuperPositions")).balanceOf(receiverAddress, superformId),
            SuperPositions(getContract(ETH, "SuperPositions")).balanceOf(receiverAddress, superformId),
            100,
            LiqRequest(_buildMaliciousTxData(1, DAI, superform, ETH, 2e18, receiverAddress), DAI, address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        SuperPositions(getContract(ETH, "SuperPositions")).increaseAllowance(
            getContract(ETH, "SuperformRouter"), superformId, 1e18
        );

        /// @dev approves before call
        vm.expectRevert(Error.DIRECT_WITHDRAW_INVALID_LIQ_REQUEST.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultWithdraw(req);
    }

    function test_superformDirectWithdrawVaultImplementationFailed() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        VaultMockFailedWithdraw vault =
            new VaultMockFailedWithdraw(IERC20(getContract(ETH, "DAI")), "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );
        /// @dev Creating superform using formImplementationId and failed deposit vault
        (uint256 superformId,) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        vm.stopPrank();
        address router = getContract(ETH, "SuperformRouter");
        vm.startPrank(router);
        SuperPositions(getContract(ETH, "SuperPositions")).mintSingle(deployer, superformId, 1e18);
        vm.stopPrank();

        vm.startPrank(deployer);
        /// @dev superform data with 1e18 final amount
        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        SuperPositions(getContract(ETH, "SuperPositions")).setApprovalForAll(router, true);

        vm.expectRevert(Error.VAULT_IMPLEMENTATION_FAILED.selector);
        SuperformRouter(payable(router)).singleDirectSingleVaultWithdraw(req);
    }

    function test_superformDirectWithdrawZeroCollateral() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superRegistry = getContract(chainId, "SuperRegistry");

        /// @dev Deploying Forms
        address formImplementation = address(new ERC4626Form(superRegistry));
        uint32 formImplementationId = 0;

        VaultMockFailedWithdraw vault =
            new VaultMockFailedWithdraw(IERC20(getContract(ETH, "DAI")), "Mock Vault", "Mock");

        // Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        SuperformFactory(getContract(chainId, "SuperformFactory")).addFormImplementation(
            formImplementation, formImplementationId, 1
        );
        /// @dev Creating superform using formImplementationId and failed deposit vault
        (uint256 superformId,) = SuperformFactory(getContract(chainId, "SuperformFactory")).createSuperform(
            formImplementationId, address(vault)
        );

        vm.stopPrank();
        address router = getContract(ETH, "SuperformRouter");
        vm.startPrank(router);
        SuperPositions(getContract(ETH, "SuperPositions")).mintSingle(deployer, superformId, 1e18);
        vm.stopPrank();

        vm.startPrank(deployer);
        /// @dev superform data with 1e18 final amount
        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            1,
            1,
            10_000,
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        SuperPositions(getContract(ETH, "SuperPositions")).setApprovalForAll(router, true);

        vm.expectRevert(Error.WITHDRAW_ZERO_COLLATERAL.selector);
        SuperformRouter(payable(router)).singleDirectSingleVaultWithdraw(req);
    }

    function test_superformXChainWithdrawalWithoutUpdatingTxData() public {
        /// @dev prank deposits (just mint super-shares)
        _successfulDeposit(false);

        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        IBaseForm(superform).getVaultAddress();

        MockERC20(getContract(ETH, "DAI")).transfer(superform, 1e18);
        vm.stopPrank();

        /// @dev simulating withdrawals with malicious tx data
        vm.startPrank(getContract(ETH, "CoreStateRegistry"));

        InitSingleVaultData memory data = InitSingleVaultData(
            1,
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest(bytes(""), getContract(ETH, "DAI"), address(0), 1, ARBI, 0),
            false,
            false,
            receiverAddress,
            ""
        );

        vm.expectRevert(Error.WITHDRAW_TX_DATA_NOT_UPDATED.selector);
        IBaseForm(superform).xChainWithdrawFromVault(data, deployer, ARBI);
    }

    function test_superformXChainWithdrawalWithoutUpdatingToken() public {
        _successfulDeposit(false);
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        MockERC20(getContract(ETH, "DAI")).transfer(superform, 1e18);
        vm.stopPrank();

        vm.startPrank(getContract(ETH, "CoreStateRegistry"));

        InitSingleVaultData memory data = InitSingleVaultData(
            1,
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest(
                _buildDummyTxDataUnitTests(
                    BuildDummyTxDataUnitTestsVars(
                        1,
                        getContract(ETH, "WETH"),
                        getContract(ETH, "DAI"),
                        superform,
                        ETH,
                        ETH,
                        1e18,
                        getContract(ETH, "CoreStateRegistry"),
                        false
                    )
                ),
                address(0),
                address(0),
                1,
                ARBI,
                0
            ),
            false,
            false,
            receiverAddress,
            ""
        );

        vm.expectRevert(Error.WITHDRAW_TOKEN_NOT_UPDATED.selector);

        IBaseForm(superform).xChainWithdrawFromVault(data, deployer, ARBI);

        vm.stopPrank();
    }

    function test_superformXChainWithdrawal_NonExistentSuperform() public {
        /// @dev prank deposits (just mint super-shares)
        _successfulDeposit(false);

        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        IBaseForm(superform).getVaultAddress();

        MockERC20(getContract(ETH, "DAI")).transfer(superform, 1e18);
        vm.stopPrank();

        /// @dev simulating withdrawals with malicious tx data
        vm.startPrank(getContract(ETH, "CoreStateRegistry"));

        InitSingleVaultData memory data = InitSingleVaultData(
            1,
            1,
            1e18,
            1e18,
            100,
            LiqRequest(bytes(""), getContract(ETH, "DAI"), address(0), 1, ARBI, 0),
            false,
            false,
            receiverAddress,
            ""
        );

        vm.expectRevert(Error.SUPERFORM_ID_NONEXISTENT.selector);
        IBaseForm(superform).xChainWithdrawFromVault(data, deployer, ARBI);
    }

    function test_superformXChainWithdrawalWithMaliciousTxData() public {
        /// @dev prank deposits (just mint super-shares)
        _successfulDeposit(false);

        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        uint256 amount = SuperPositions(getContract(ETH, "SuperPositions")).balanceOf(receiverAddress, superformId);

        vm.prank(deployer);
        MockERC20(getContract(ETH, "DAI")).transfer(superform, 1e18);

        /// @dev simulating withdrawals with malicious tx data
        vm.startPrank(getContract(ETH, "CoreStateRegistry"));

        InitSingleVaultData memory data = InitSingleVaultData(
            1,
            superformId,
            amount,
            amount,
            100,
            LiqRequest(
                _buildMaliciousTxData(1, getContract(ETH, "DAI"), superform, ARBI, 2e18, receiverAddress),
                getContract(ETH, "DAI"),
                address(0),
                1,
                ARBI,
                0
            ),
            false,
            false,
            receiverAddress,
            ""
        );

        vm.expectRevert(Error.XCHAIN_WITHDRAW_INVALID_LIQ_REQUEST.selector);
        IBaseForm(superform).xChainWithdrawFromVault(data, deployer, ARBI);
    }

    function test_revert_baseForm_notSuperRegistry() public {
        vm.startPrank(deployer);

        vm.selectFork(FORKS[chainId]);

        SuperformFactory superformFactory = SuperformFactory(getContract(chainId, "SuperformFactory"));

        address newSr = address(new SuperRegistry(address(0x2222)));
        vm.mockCall(
            newSr, abi.encodeWithSelector(SuperRegistry(newSr).getStateRegistry.selector, 1), abi.encode(address(0x444))
        );
        /// @dev Deploying Form with incorrect SuperRegistry
        address formImplementation = address(new ERC4626Form(newSr));
        vm.clearMockedCalls();

        uint32 formImplementationId = 0;

        /// @dev Vaults For The Superforms
        MockERC20 asset = new MockERC20("Mock ERC20 Token", "Mock", address(this), uint256(1000));
        VaultMock vault = new VaultMock(asset, "Mock Vault", "Mock");

        /// @dev Deploying Forms Using AddImplementation. Not Testing Reverts As Already Tested
        superformFactory.addFormImplementation(formImplementation, formImplementationId, 1);

        /// @dev should revert as superRegistry coming from SuperformFactory does not
        /// match the one set in the ERC4626Form
        vm.expectRevert(Error.NOT_SUPER_REGISTRY.selector);
        superformFactory.createSuperform(formImplementationId, address(vault));
    }

    function test_directDeposit_DIFFERENT_TOKENS() public {
        /// @dev no txData is sent for a vault that requires it
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);
        address superformRouter = getContract(ETH, "SuperformRouter");

        address superform2 = getContract(
            ETH, string.concat("WETH", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId2 = DataLib.packSuperform(superform2, FORM_IMPLEMENTATION_IDS[0], ETH);

        uint256[] memory superformIds = new uint256[](1);
        superformIds[0] = superformId2;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 1e18;

        uint256[] memory outputAmounts = new uint256[](1);
        outputAmounts[0] = 1e18;

        uint256[] memory maxSlippages = new uint256[](1);
        maxSlippages[0] = 1000;

        LiqRequest[] memory liqReqs = new LiqRequest[](1);

        liqReqs[0] = LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0);

        MultiVaultSFData memory data = MultiVaultSFData(
            superformIds,
            amounts,
            outputAmounts,
            maxSlippages,
            liqReqs,
            "",
            new bool[](1),
            new bool[](1),
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectMultiVaultStateReq memory req = SingleDirectMultiVaultStateReq(data);

        /// @dev approves before call
        MockERC20(getContract(ETH, "DAI")).approve(address(superformRouter), 1e18);

        vm.expectRevert(Error.DIFFERENT_TOKENS.selector);
        SuperformRouter(payable(superformRouter)).singleDirectMultiVaultDeposit{ value: 10 ether }(req);
        vm.stopPrank();
    }

    function test_directDeposit_DIFFERENT_TOKENS_OUTPUT_TOKEN() public {
        /// @dev no txData is sent for a vault that requires it
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);
        address superformRouter = getContract(ETH, "SuperformRouter");

        address superform2 = getContract(
            ETH, string.concat("WETH", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId2 = DataLib.packSuperform(superform2, FORM_IMPLEMENTATION_IDS[0], ETH);

        uint256[] memory superformIds = new uint256[](1);
        superformIds[0] = superformId2;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 1e18;

        uint256[] memory outputAmounts = new uint256[](1);
        outputAmounts[0] = 1e18;

        uint256[] memory maxSlippages = new uint256[](1);
        maxSlippages[0] = 1000;

        LiqRequest[] memory liqReqs = new LiqRequest[](1);

        liqReqs[0] = LiqRequest(
            _buildDummyTxDataUnitTests(
                BuildDummyTxDataUnitTestsVars(
                    1, getContract(ETH, "DAI"), getContract(ETH, "USDC"), superform2, ETH, ETH, 1e18, superform2, true
                )
            ),
            getContract(ETH, "DAI"),
            address(0),
            1,
            ETH,
            0
        );

        MultiVaultSFData memory data = MultiVaultSFData(
            superformIds,
            amounts,
            outputAmounts,
            maxSlippages,
            liqReqs,
            "",
            new bool[](1),
            new bool[](1),
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectMultiVaultStateReq memory req = SingleDirectMultiVaultStateReq(data);

        /// @dev approves before call
        MockERC20(getContract(ETH, "DAI")).approve(address(superformRouter), 1e18);

        vm.expectRevert(Error.DIFFERENT_TOKENS.selector);
        SuperformRouter(payable(superformRouter)).singleDirectMultiVaultDeposit{ value: 10 ether }(req);
        vm.stopPrank();
    }

    function test_successfulDeposit_insufficientAllowance() public {
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
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        vm.mockCall(
            getContract(ETH, "DAI"),
            abi.encodeWithSelector(IERC20(getContract(ETH, "DAI")).allowance.selector, router, superform),
            abi.encode(0)
        );
        /// @dev approves before call
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);
        vm.expectRevert(Error.INSUFFICIENT_ALLOWANCE_FOR_DEPOSIT.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);

        data = SingleVaultSFData(
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest(
                _buildDummyTxDataUnitTests(
                    BuildDummyTxDataUnitTestsVars(
                        1,
                        getContract(ETH, "DAI"),
                        getContract(ETH, "DAI"),
                        superform,
                        ETH,
                        ETH,
                        1e18,
                        getContract(ETH, "CoreStateRegistry"),
                        false
                    )
                ),
                getContract(ETH, "DAI"),
                address(0),
                1,
                ETH,
                0
            ),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );
        req = SingleDirectSingleVaultStateReq(data);
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);
        vm.expectRevert(Error.INSUFFICIENT_ALLOWANCE_FOR_DEPOSIT.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);

        vm.clearMockedCalls();
    }

    function test_maliciousBridge_protectionAgainstTokenDrain() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        uint256 daiAmount = 10 * 1e18; // 10 DAI
        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        /// @dev uses id 4 for bridge "LifiMockRugpull"
        LiqBridgeTxDataArgs memory liqBridgeTxDataArgs = LiqBridgeTxDataArgs(
            4,
            getContract(ETH, "DAI"),
            getContract(ETH, "DAI"),
            getContract(ETH, "DAI"),
            superform,
            ETH,
            ETH,
            ETH,
            false,
            superform,
            uint256(ETH),
            daiAmount,
            false,
            0,
            1,
            1,
            1,
            address(0)
        );

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            daiAmount,
            daiAmount,
            100,
            LiqRequest(_buildLiqBridgeTxData(liqBridgeTxDataArgs, true), getContract(ETH, "DAI"), address(0), 4, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        /// Make Superform's initial balance to 10 DAI
        MockERC20(getContract(ETH, "DAI")).transfer(superform, daiAmount);

        /// Single deposit 10 DAI to the Superform
        MockERC20(getContract(ETH, "DAI")).approve(router, daiAmount);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);

        /// Bridge tries to drain Superform's tokens and it fails
        vm.expectRevert();
        LiFiMockRugpull(payable(getContract(ETH, "LiFiMockRugpull"))).pullTokens(getContract(ETH, "DAI"), superform);
    }

    function test_blacklistedSelectors_reverts() public {
        vm.selectFork(FORKS[ETH]);
        vm.startPrank(deployer);

        uint256 daiAmount = 10 * 1e18; // 10 DAI
        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        bytes32 txId = keccak256("blacklisted");
        bytes memory blacklistedTxData = abi.encodeWithSelector(
            LiFiMockBlacklisted.startBridgeTokensViaCBridgeNativeMin.selector, txId, address(0x1), 5, 5, 100
        );

        SingleVaultSFData memory data = SingleVaultSFData(
            superformId,
            daiAmount,
            daiAmount,
            100,
            LiqRequest(blacklistedTxData, getContract(ETH, "DAI"), address(0), 5, ETH, 0),
            "",
            false,
            false,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        /// Make Superform's initial balance to 10 DAI
        MockERC20(getContract(ETH, "DAI")).transfer(superform, daiAmount);

        /// Single deposit 10 DAI to the Superform
        MockERC20(getContract(ETH, "DAI")).approve(router, daiAmount);
        vm.expectRevert(Error.BLACKLISTED_SELECTOR.selector);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);
    }

    function test_processXChainDeposit_InsufficientAllowance() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);

        InitSingleVaultData memory data = InitSingleVaultData(
            1,
            superformId,
            1e18,
            1e18,
            100,
            LiqRequest(bytes(""), getContract(ETH, "DAI"), address(0), 1, ARBI, 0),
            false,
            false,
            receiverAddress,
            ""
        );

        vm.prank(getContract(ETH, "CoreStateRegistry"));
        vm.expectRevert(Error.INSUFFICIENT_ALLOWANCE_FOR_DEPOSIT.selector);
        IBaseForm(superform).xChainDepositIntoVault(data, deployer, POLY);
    }

    function test_directDepositIntoVault_SuperformIdNonexistent() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 nonexistentSuperformId = 123;
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            nonexistentSuperformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.prank(getContract(ETH, "SuperformRouter"));
        vm.expectRevert(Error.SUPERFORM_ID_NONEXISTENT.selector);
        ERC4626Form(payable(superform)).directDepositIntoVault(data, address(0));
    }

    function test_xChainDepositIntoVault_SuperformIdNonexistent() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 nonexistentSuperformId = 123;
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            nonexistentSuperformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.prank(getContract(ETH, "CoreStateRegistry"));
        vm.expectRevert(Error.SUPERFORM_ID_NONEXISTENT.selector);
        ERC4626Form(payable(superform)).xChainDepositIntoVault(data, address(0), 1);
    }

    function test_directDepositIntoVault_Paused() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            superformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.prank(deployer);
        SuperformFactory(getContract(ETH, "SuperformFactory")).changeFormImplementationPauseStatus(
            FORM_IMPLEMENTATION_IDS[0], ISuperformFactory.PauseStatus.PAUSED, bytes("")
        );

        vm.prank(getContract(ETH, "SuperformRouter"));
        vm.expectRevert(Error.PAUSED.selector);
        ERC4626Form(payable(superform)).directDepositIntoVault(data, address(0));
    }

    function test_xChainDepositIntoVault_Paused() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );
        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            superformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.prank(deployer);
        SuperformFactory(getContract(ETH, "SuperformFactory")).changeFormImplementationPauseStatus(
            FORM_IMPLEMENTATION_IDS[0], ISuperformFactory.PauseStatus.PAUSED, bytes("")
        );

        vm.prank(getContract(ETH, "CoreStateRegistry"));
        vm.expectRevert(Error.PAUSED.selector);
        ERC4626Form(payable(superform)).xChainDepositIntoVault(data, address(0), 1);
    }

    function test_xChainDepositIntoVault_NotCoreStateRegistry() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            superformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.prank(address(1));
        vm.expectRevert(Error.NOT_CORE_STATE_REGISTRY.selector);
        ERC4626Form(payable(superform)).xChainDepositIntoVault(data, address(0), 0);
    }

    function test_emergencyWithdraw_NotEmergencyQueue() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        vm.prank(address(1));
        vm.expectRevert(Error.NOT_EMERGENCY_QUEUE.selector);
        ERC4626Form(payable(superform)).emergencyWithdraw(address(0), 0);
    }

    function test_xChainDepositIntoVault_InvalidChainId() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            superformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.expectRevert(Error.INVALID_CHAIN_ID.selector);
        vm.prank(getContract(ETH, "CoreStateRegistry"));
        ERC4626Form(payable(superform)).xChainDepositIntoVault(data, users[0], 0);
    }

    function test_xChainWithdrawFromVault_InvalidChainId() public {
        vm.selectFork(FORKS[ETH]);

        address superform = getContract(
            ETH, string.concat("DAI", "VaultMock", "Superform", Strings.toString(FORM_IMPLEMENTATION_IDS[0]))
        );

        uint256 superformId = DataLib.packSuperform(superform, FORM_IMPLEMENTATION_IDS[0], ETH);
        InitSingleVaultData memory data = InitSingleVaultData(
            0,
            superformId,
            0,
            0,
            0,
            LiqRequest(bytes(""), address(0), address(0), 0, 0, 0),
            false,
            false,
            address(0),
            ""
        );

        vm.expectRevert(Error.INVALID_CHAIN_ID.selector);
        vm.prank(getContract(ETH, "CoreStateRegistry"));
        ERC4626Form(payable(superform)).xChainWithdrawFromVault(data, users[0], 0);
    }

    /*///////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _successfulDeposit(bool retain4626) internal {
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
            LiqRequest("", getContract(ETH, "DAI"), address(0), 1, ETH, 0),
            "",
            false,
            retain4626,
            receiverAddress,
            receiverAddress,
            ""
        );

        SingleDirectSingleVaultStateReq memory req = SingleDirectSingleVaultStateReq(data);

        address router = getContract(ETH, "SuperformRouter");

        /// @dev approves before call
        MockERC20(getContract(ETH, "DAI")).approve(router, 1e18);
        SuperformRouter(payable(getContract(ETH, "SuperformRouter"))).singleDirectSingleVaultDeposit(req);
        vm.stopPrank();
    }

    function _buildMaliciousTxData(
        uint8 liqBridgeKind_,
        address underlyingToken_,
        address from_,
        uint64 toChainId_,
        uint256 amount_,
        address receiver_
    )
        internal
        view
        returns (bytes memory txData)
    {
        if (liqBridgeKind_ == 1) {
            ILiFi.BridgeData memory bridgeData;
            LibSwap.SwapData[] memory swapData = new LibSwap.SwapData[](1);

            swapData[0] = LibSwap.SwapData(
                address(0),
                /// callTo (arbitrary)
                address(0),
                /// callTo (approveTo)
                underlyingToken_,
                underlyingToken_,
                amount_,
                abi.encode(from_, FORKS[toChainId_]),
                false // arbitrary
            );

            bridgeData = ILiFi.BridgeData(
                bytes32("1"),
                /// request id
                "",
                "",
                address(0),
                underlyingToken_,
                receiver_,
                amount_,
                uint256(toChainId_),
                false,
                true
            );

            txData = abi.encodeWithSelector(LiFiMock.swapAndStartBridgeTokensViaBridge.selector, bridgeData, swapData);
        }
    }
}
