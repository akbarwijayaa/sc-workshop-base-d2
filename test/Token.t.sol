// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Token} from "../src/Token.sol";


contract TokenTest is Test {
    Token token;
    address public owner = makeAddr("owner");
    address public user1 = makeAddr("user1");
    address public minter = makeAddr("minter");

    function setUp() public {
        vm.startPrank(owner);
        token = new Token("MyToken", "MTK", minter);
        vm.stopPrank();
    }

    function testInitialDeploy() public view {
        assertEq(token.name(), "MyToken");
        console.log(token.name());
        assertEq(token.symbol(), "MTK");
        console.log(token.symbol());
        assertEq(token.totalSupply(), 0);
        console.log(token.totalSupply());
        assertEq(token.balanceOf(owner), 0);
        console.log(token.balanceOf(owner));
    }

    function testMint() public {
        uint256 mintAmount = 1000;
        vm.startPrank(minter);
        token.mint(user1, mintAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), mintAmount);
    }

    function testUnauthorizedMint() public {
        vm.startPrank(user1);
        vm.expectRevert();
        token.mint(user1, 1000);
        vm.stopPrank();
    }

    function testMintOwnable() public {
        uint256 mintAmount = 1000;
        vm.startPrank(minter);
        token.mint(user1, mintAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), mintAmount);
    }

    function testRevertMintingByNonOwner() public {
        vm.startPrank(user1);
        vm.expectRevert();
        token.mint(user1, 1000);
        vm.stopPrank();
    }

    function testPublicMint() public {
        uint256 mintAmount = 500;
        vm.startPrank(user1);
        token.publicMint(user1, mintAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), mintAmount);
    }

    function testPause() public {
        vm.prank(owner);
        token.pause();

        vm.prank(minter);
        vm.expectRevert();
        token.mint(user1, 1000);

        vm.prank(owner);
        token.unpause();

        vm.prank(minter);
        token.mint(user1, 1000);

        assertEq(token.balanceOf(user1), 1000);
    }
}
