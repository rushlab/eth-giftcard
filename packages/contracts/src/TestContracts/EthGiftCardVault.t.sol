// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import { stdCheats } from "forge-std/stdlib.sol";

import "../EthGiftCardVault.sol";
import "../EthGiftCardItem.sol";
import "../Proxy.sol";


contract EthGiftCardVaultTest is DSTest, stdCheats {
    EthGiftCardVault vault;
    address implementation;
    address fromAccount = address(uint160(uint256(keccak256('from account'))));
    address receiverAccount = address(uint160(uint256(keccak256('receiver account'))));

    function setUp() public {
        vault = new EthGiftCardVault();
        implementation = address(new EthGiftCardItem());
    }

    function testMint() public {
        hoax(fromAccount, 10 ether);
        address proxyAddress = vault.mint{
            value: 1.2 ether
        }(receiverAccount, 1 ether, 0.2 ether, implementation);

        EthGiftCardItem ethGiftCardItem = EthGiftCardItem(proxyAddress);

        assertEq(ethGiftCardItem.ownerOf(0), receiverAccount);
        assertEq(fromAccount.balance, 8.8 ether);
    }

    function testBurn() public {
        startHoax(fromAccount, 10 ether);
        address proxyAddress = vault.mint{
            value: 1.2 ether
        }(receiverAccount, 1 ether, 0.2 ether, implementation);

        EthGiftCardItem ethGiftCardItem = EthGiftCardItem(proxyAddress);

        startHoax(receiverAccount, 0);
        ethGiftCardItem.burn();

        assertEq(receiverAccount.balance, 1.2 ether);
    }

}
