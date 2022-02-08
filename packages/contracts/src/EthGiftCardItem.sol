// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "openzeppelin-contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";


contract EthGiftCardItem is ERC721Upgradeable {

    uint256 amount;
    uint256 gasCompensation;

    function initialize(
        address receiver_,
        uint256 amount_,
        uint256 gasCompensation_
    ) initializer external payable {
        require(msg.value == amount_ + gasCompensation_, "Incorrect ether value sent");
        amount = amount_;
        gasCompensation = gasCompensation_;
        _safeMint(receiver_, 0);
    }

    function burn() external {
        address owner = ownerOf(0);
        require(msg.sender == owner, "Burn caller is not owner");
        selfdestruct(payable(owner));
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view override returns (string memory) {
        return "ETH Gift Card";
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view override returns (string memory) {
        return "GIFTCARD";
    }

}
