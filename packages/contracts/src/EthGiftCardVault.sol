// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./EthGiftCardItem.sol";
import "./Proxy.sol";


contract EthGiftCardVault {

    constructor() {}

    /**
     * Anyone can mint
     */
    function mint(
        address receiver,
        uint256 amount,
        uint256 gasCompensation,
        address implementation
    ) payable external returns (
        address proxyAddress
    ) {
        require(msg.value == amount + gasCompensation, "Incorrect ether value sent");

        Proxy giftCardProxy = new Proxy(implementation);
        proxyAddress = address(giftCardProxy);

        EthGiftCardItem giftCardItem = EthGiftCardItem(proxyAddress);
        giftCardItem.initialize{value: msg.value}(receiver, amount, gasCompensation);
    }

}
