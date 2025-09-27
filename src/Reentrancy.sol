// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Token} from "./Token.sol";
import {ReentrancyGuard} from "@openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

contract Vault is ReentrancyGuard {
    Token public token;
    mapping(address => uint256) public balances;

    error InsufficientBalance();

    constructor(address _token) {
        token = Token(_token);
    }

    function deposit() external payable nonReentrant {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external nonReentrant {
        if (balances[msg.sender] < amount) revert InsufficientBalance();

        balances[msg.sender] -= amount;

        token.transferFrom(msg.sender, address(this), amount);

    }
}
