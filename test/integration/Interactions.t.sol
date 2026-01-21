// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {Raffle} from "src/Raffle.sol";
import {DeployRaffle} from "script/DeployRaffle.s.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract Interactions is Test {
    uint256 entranceFee;
    uint256 interval;
    address vrfCoordinator;
    bytes32 gasLane;
    uint256 subscriptionId;
    uint32 callbackGasLimit;
    Raffle public raffle;
    HelperConfig public helperConfig;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.deployContract();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        entranceFee = config.entranceFee;
        interval = config.interval;
        vrfCoordinator = config.vrfCoordinator;
        gasLane = config.gasLane;
        subscriptionId = config.subscriptionId;
        callbackGasLimit = config.callbackGasLimit;
    }

    /*//////////////////////////////////////////////////////////////
                            RAFFLEDEPLOYMENT
    //////////////////////////////////////////////////////////////*/

    function testRaffleDeployedCorrectly() external {
        // Arrang / Act / Assert
        assert(address(raffle) != address(0));
        // enum comparison via uint cast (forge-std has no enum assertEq)
        assertEq(
            uint256(raffle.getRaffleState()),
            uint256(Raffle.RaffleState.OPEN)
        );
    }

    /*//////////////////////////////////////////////////////////////
                              RAFFLECONFIG
    //////////////////////////////////////////////////////////////*/

    function testRaffleUsesCorrectConfig() external {
        assertEq(raffle.getEntranceFee(), entranceFee);
        assertEq(raffle.getInterval(), interval);
        assertEq(raffle.getGasLane(), gasLane);
        assertGt(raffle.getSubscriptionId(), 0);
        assertEq(raffle.getCallbackGasLimit(), callbackGasLimit);
    }

    /*//////////////////////////////////////////////////////////////
                        USER FLOW (INTERACTION)
//////////////////////////////////////////////////////////////*/

    function testUserCanEnterRaffleAfterDeployment() external {
        // Arrange
        address player = makeAddr("player");
        vm.deal(player, 1 ether);

        uint256 fee = raffle.getEntranceFee();

        // Act
        vm.prank(player);
        raffle.enterRaffle{value: fee}();

        // Assert
        assertEq(raffle.getNumberOfPlayers(), 1);
        assertEq(raffle.getPlayer(0), player);
    }
}
