// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {Factory} from "../src/Factory.sol";


contract FactoryTest is Test {
    Factory factory;

    address public user1 = makeAddr("user1");
    address public minter = makeAddr("minter");

    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address deployer = vm.addr(deployerPrivateKey);

    function setUp() public {
        factory = new Factory();
    }

    function testCreateToken() public {
        string memory name = "Akbar";
        string memory symbol = "AKB";

        address tokenAddress = factory.createToken(name, symbol, minter);
        assertTrue(tokenAddress != address(0));

        Token token = Token(tokenAddress);
        console.log("Token Name: ", token.name());
        console.log("Token Symbol: ", token.symbol());


    }
}
