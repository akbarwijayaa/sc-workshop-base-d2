// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin-contracts/contracts/access/Ownable.sol";
import {AccessControl} from "@openzeppelin-contracts/contracts/access/AccessControl.sol";
import {Pausable} from "@openzeppelin-contracts/contracts/utils/Pausable.sol";

contract Token is ERC20, Ownable, AccessControl, Pausable {

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    event Mint(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    error Unauthorized();

    constructor(string memory name, string memory symbol, address _minterRole) ERC20(name, symbol) Ownable(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, _minterRole);
    }

    function mint(address to, uint256 amount) external whenNotPaused onlyRole(MINTER_ROLE) {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function burn(address from, uint256 amount) external whenNotPaused onlyRole(MINTER_ROLE) {
        _burn(from, amount);
        emit Burned(from, amount);
    }

    function publicMint(address to, uint256 amount) external whenNotPaused {
        _mint(to, amount);

        emit Mint(to, amount);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}
