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

    mapping(uint256 => GiftCard) private giftcardInfo;

    constructor() ERC721("ETH Gift Card", "GIFTCARD") {
        //
    }

    /**
     * Anyone can mint
     */
    function mint() payable external {
        _mintIndex = _mintIndex + 1;
        _safeMint(msg.sender, _mintIndex);
    }

    /**
     * Owner can burn, and get eth
     */
    function burn() external {
        //
    }

}
