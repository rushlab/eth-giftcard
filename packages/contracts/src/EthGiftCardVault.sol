// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./EthGiftCardItem.sol";


contract EthGiftCardVault {

    constructor() {}

    /**
     * Anyone can mint
     */
    function mint(
        address receiver,
        uint256 amount,
        uint256 gasCompensation
    ) payable external returns (
        EthGiftCardItem giftCard
    ) {
        require(msg.value == amount + gasCompensation, "Incorrect ether value sent");

        giftCard = new EthGiftCardItem(receiver, amount, gasCompensation);
        payable(address(giftCard)).transfer(msg.value);
    }

}
