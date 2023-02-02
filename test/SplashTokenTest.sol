// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "forge-std/Test.sol";
import "../contracts/SplashToken.sol";

contract SplashTokenTest is Test {
    address public alice = address(0x0);
    address public bob = address(0x1);
    SplashToken public token;

    /// @notice Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function setUp() public {
        token = new SplashToken("Splash", "SPLSH", 100000000);
    }

    function testName() public {
        assertEq(token.name(), "Splash");
    }

    function testTotalSupply() public {
        assertEq(token.totalSupply(), 100000000 * 10**18);
    }

    function testTransferToken() public {
        address sender = address(this);
        uint256 amount = 1;

        vm.expectEmit(true, true, false, true);
        emit Approval(sender, sender, amount);
        token.approve(sender, amount);

        vm.expectEmit(true, true, false, true);
        emit Transfer(sender, bob, amount);
        token.transferFrom(sender, bob, amount);

        uint256 bobBalance = token.balanceOf(bob);
        assertEq(bobBalance, amount);
    }
}
