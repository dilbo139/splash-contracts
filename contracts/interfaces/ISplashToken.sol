// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import {IERC20} from './IERC20.sol';

interface ISplashToken is IERC20 {
  function _transfer(
    address from,
    address to,
    uint256 amount
  ) external;

  function mint(address to, uint256 amount) external;

  function burn(address from, uint256 amount) external;
}
