// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "openzeppelin-contracts/interfaces/IERC721.sol";
import "openzeppelin-contracts/interfaces/IERC165.sol";
// import "openzeppelin-contracts/token/ERC721/ERC721.sol";
// import "openzeppelin-contracts/utils/introspection/ERC165.sol";


contract EthGiftCardItem {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    address payable receiver;
    uint256 amount;
    uint256 gasCompensation;

    constructor(
        address receiver_,
        uint256 amount_,
        uint256 gasCompensation_
    ) {
        receiver = payable(receiver_);
        amount = amount_;
        gasCompensation = gasCompensation_;
        emit Transfer(address(0), receiver, 0);
    }

    function burn() external {
        require(msg.sender == receiver, "Burn caller is not owner");
        selfdestruct(receiver);
    }

    receive() payable external {}

    /* IERC721 */

    function supportsInterface(bytes4 interfaceId) public view /* override(ERC165, IERC165) */ returns (bool) {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId;
    }

    function balanceOf(address owner) external view returns (uint256) {
        require(owner == receiver);
        return 1;
    }

    function ownerOf(uint256 tokenId) external view returns (address) {
        require(tokenId == 0);
        return receiver;
    }

    // function safeTransferFrom(address from, address to, uint256 tokenId) external override {
    //     require(false);
    // }

    // function transferFrom(address from, address to, uint256 tokenId) external override {
    //     require(false);
    // }

    // function approve(address to, uint256 tokenId) external override {
    //     require(false);
    // }

    // function getApproved(uint256 tokenId) external view override returns (address) {
    //     return address(0);
    // }

    // function setApprovalForAll(address operator, bool _approved) external override {
    //     require(false);
    // }

    // function isApprovedForAll(address owner, address operator) external view override returns (bool) {
    //     return false;
    // }

    // function safeTransferFrom(
    //     address from, address to, uint256 tokenId, bytes calldata data
    // ) external override {
    //     require(false);
    // }

}
