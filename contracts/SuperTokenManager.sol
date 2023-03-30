// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.14;

import {ISuperToken, IERC20} from '@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol';
import {ISplashToken} from './interfaces/ISplashToken.sol';

// Deploy this contract on **Goerli Testnet** to begin experimenting
// Alternatively, use pre-deployed contract at 0x7c7A61e744be5abA305701359e44714EC7e71fc5 and this as an interface for interacting on Remix
contract SuperTokenManager {
  ISuperToken public splashx =
    ISuperToken(0x4614d9ce1f88B168752babF3D54F70768C10180D);

  /// @dev Mints 10,000 fDAI to this contract and wraps (upgrades) it all into fDAIx
  /// fDAI has a convenient public mint function so we can get as much as we need
  function gainSplashx() external {
    // Get address of fDAI by getting underlying token address from DAIx token
    ISplashToken splash = ISplashToken(splashx.getUnderlyingToken());

    // Mint 10,000 fDAI
    splash.mint(address(this), 10000e18);

    // Approve fDAIx contract to spend fDAI
    splash.approve(address(splashx), 20000e18);

    // Wrap the fDAI into fDAIx
    splashx.upgrade(10000e18);
  }

  /// @dev Unwraps (downgrades) chosen amount of fDAIx into DAIx
  /// @param amount - quantity of fDAIx being downgraded
  function losefDAIx(uint256 amount) external {
    // Unwrap the fDAIx into fDAI
    splashx.downgrade(amount);
  }

  /// @dev Show fDAI balance of this contract
  /// @return Balance of fDAI in this contract
  function getSplashBalance() external view returns (uint256) {
    // Get address of fDAI by getting underlying token address from DAIx token
    IERC20 splash = IERC20(splashx.getUnderlyingToken());

    return splash.balanceOf(address(this));
  }

  /// @dev Show fDAIx balance of this contract
  /// @return Balance of fDAIx in this contract
  function getSplashxBalance() external view returns (uint256) {
    return splashx.balanceOf(address(this));
  }
}
