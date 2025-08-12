// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Decentralized Stable Coin
 * @author alenissacsam
 * Collateral : Exogenous (ETH & BTC)
 * Minting : Alogorithmic
 * Relative Stability : Pegged to USD
 *
 * This contract is governed by DSCEngine
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedBalance();
    error DecentralizedStableCoin__ZeroAddress();

    constructor() ERC20("DecentralizedStableCoin", "DSC") {}

    function burn(uint256 value) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (value == 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        } else if (value > balance) {
            revert DecentralizedStableCoin__BurnAmountExceedBalance();
        }

        super.burn(value);
    }

    function mint(address to, uint256 amount) external onlyOwner returns (bool) {
        if (to == address(0)) {
            revert DecentralizedStableCoin__ZeroAddress();
        } else if (amount < 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }

        _mint(to, amount);
        return true;
    }
}
