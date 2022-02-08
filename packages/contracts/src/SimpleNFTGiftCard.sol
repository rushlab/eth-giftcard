// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "./SignatureVerification.sol";


contract EthGiftCard is ERC721, Ownable {

    uint256 private _mintIndex;

    struct GiftCard {
        uint256 amount;  // eth in wei
        uint256 gasCompensation;  // eth in wei
    }

    mapping(uint256 => GiftCard) private _giftCards;

    constructor() ERC721("ETH Gift Card", "GIFTCARD") {
        //
    }

    /**
     * Anyone can mint
     */
    function mint(
        address receiver,
        uint256 amount,
        uint256 gasCompensation
    ) payable external {
        require(msg.value == amount + gasCompensation, "Incorrect ether value sent");

        _mintIndex = _mintIndex + 1;
        _safeMint(receiver, _mintIndex);

        GiftCard memory giftCard;
        giftCard.amount = amount;
        giftCard.gasCompensation = gasCompensation;
        _giftCards[_mintIndex] = giftCard;
    }

    /**
     * Owner can burn, and get eth
     */
    function burn(uint256 tokenId) external {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner, "Burn caller is not owner");

        uint256 amount = _giftCards[tokenId].amount;
        // uint256 gasCompensation = _giftCards[tokenId].gasCompensation;

        _burn(tokenId);
        delete _giftCards[tokenId];

        payable(address(owner)).transfer(amount);
        // gasCompensation;
    }

}
