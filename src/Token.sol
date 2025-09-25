// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public owner;
    event Mint(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    error Unauthorized();

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
        
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
        emit Burned(from, amount);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }
}
