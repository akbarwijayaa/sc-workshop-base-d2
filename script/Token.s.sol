// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;

    address public minter = makeAddr("minter");
    function run() external returns (address) {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);
        token = new Token("FUFUFAFA", "FFF", minter);
        console.log("Token deployed at:", address(token));
        vm.stopBroadcast();

        return (address(token));
    }
}
