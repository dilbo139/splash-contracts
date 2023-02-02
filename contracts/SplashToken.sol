// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import "@openzeppelin/token/ERC20/ERC20.sol";

contract SplashToken is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply
    ) ERC20(name, symbol) {
        // Mint `totalSupply` tokens to msg.sender
        // Similar to how
        // 1 dollar = 100 cents
        // 1 token = 1 * (10 ** decimals)
        _mint(msg.sender, totalSupply * 10**uint256(decimals()));
    }
}
