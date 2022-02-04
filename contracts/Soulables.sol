// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Soulables is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIdCounter;
  mapping(uint256 => bytes32) private tokenIdToMetadataHash;

  constructor() ERC721("Soulables", "SLBS") {}

  function mint(address to, string memory uri) public {
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }

  function setTokenURI(uint256 tokenId, string memory _tokenURI) external {
    super._setTokenURI(tokenId, _tokenURI);
  }

  function getTokenIds(address _owner) public view returns(uint[] memory) {
    uint[] memory _tokensOfOwner = new uint[](ERC721.balanceOf(_owner));

    for (uint i = 0; i < ERC721.balanceOf(_owner); i++) {
      _tokensOfOwner[i] = ERC721Enumerable.tokenOfOwnerByIndex(_owner, i);
    }

    return _tokensOfOwner;
  }

  function getTokenMetadataHash(uint256 tokenId) public view returns(bytes32) {
    return tokenIdToMetadataHash[tokenId];
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
    internal
    override(ERC721, ERC721Enumerable)
  {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
    super._burn(tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}