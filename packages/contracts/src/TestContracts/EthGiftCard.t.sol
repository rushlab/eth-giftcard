// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import { stdCheats } from "forge-std/stdlib.sol";

import "../EthGiftCard.sol";


contract EthGiftCardTest is DSTest, stdCheats {
    EthGiftCard ethGiftCard;

    function setUp() public {
        ethGiftCard = new EthGiftCard();
    }

    function testExample() public {
        assertTrue(true);
    }

    function testMint() public {
        address testAccount = 0x85981B5db760B73FA8A6AA790c27a2C9e1BaB475;
        hoax(testAccount, 10 ether);
        ethGiftCard.mint{value: 1.2 ether}(testAccount, 1 ether, 0.2 ether);
        assertEq(ethGiftCard.ownerOf(1), testAccount);
    }
}
