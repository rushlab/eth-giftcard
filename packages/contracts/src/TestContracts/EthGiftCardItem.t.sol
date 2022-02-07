// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import { stdCheats } from "forge-std/stdlib.sol";

import "../EthGiftCardItem.sol";


contract EthGiftCardItemTest is DSTest, stdCheats {
    EthGiftCardItem ethGiftCardItem;

    function setUp() public {
        ethGiftCardItem = new EthGiftCardItem(0x0000000000000000000000000000000000000000, 0, 0);
    }
}
