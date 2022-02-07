// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
// import "openzeppelin-contracts/token/ERC721/IERC721.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "./SignatureVerification.sol";


contract EthGiftCardItem is ERC721, Ownable {

    address payable receiver;
    uint256 amount;
    uint256 gasCompensation;

    constructor(
        address receiver_,
        uint256 amount_,
        uint256 gasCompensation_
    ) ERC721("ETH Gift Card", "GIFTCARD") {
        receiver = payable(receiver_);
        amount = amount_;
        gasCompensation = gasCompensation_;
    }

    function mint() payable external onlyOwner {
        require(msg.value == amount + gasCompensation, "Incorrect ether value sent");
        _safeMint(receiver, 0);
        renounceOwnership();
    }

    /**
     * Owner can burn, and get eth
     */
    function burn() external {
        address owner = ownerOf(0);
        require(msg.sender == owner, "Burn caller is not owner");
        selfdestruct(receiver);
    }

}
