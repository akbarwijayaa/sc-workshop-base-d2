// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Token} from "./Token.sol";


contract Factory {
    event TokenCreated(address tokenAddress, string name, string symbol);

    function createToken(string memory name, string memory symbol, address _minter) external returns (address) {
        Token token = new Token(name, symbol, _minter);

        emit TokenCreated(address(token), name, symbol);
        return address(token);
    }

    function mintToken(address tokenAddress, address to, uint256 amount) external {
        Token token = Token(tokenAddress);
        token.mint(to, amount);
    }
}
