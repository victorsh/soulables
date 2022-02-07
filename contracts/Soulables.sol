// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Soulables is
  Context,
  AccessControlEnumerable,
  ERC721Enumerable,
  ERC721Pausable,
  ERC721Burnable,
  ERC721URIStorage,
  Ownable
{

  struct UserMinted {
    address minter;
    uint256 tokenId;
    bool minted;
  }

  event ToMint(address indexed owner, uint256 indexed tokenId);
  event PermenantURI(string _value, uint256 indexed _id);

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIdCounter;

  uint256 public _maxSupply = 5555;
  uint256 public _totalSupply;

  uint256 public _basePrice = 50 * 10**18;

  mapping(uint256 => UserMinted) tokenIdToUserMinted;

  /**
   * @dev Sets contract deployer to ADMIN_ROLE
   */
  constructor() ERC721("Soulables", "SLBS") {
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
  }

  /**
   * @dev Mints the actual token
   * Relies on userMint method to take payment for minting before actually minting the token
   */
  function mint(address to, uint256 tokenId, string memory uri) external onlyOwner {
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  /**
   * @dev Mints the actual token
   * Relies on userMint method to take payment for minting before actually minting the token
   */
  function mintUserToken(address to, uint256 tokenId, string memory uri) external onlyOwner {
    require(to == tokenIdToUserMinted[tokenId].minter, "Token Id must match user.");
    require(tokenId == tokenIdToUserMinted[tokenId].tokenId, "Token Id does not match.");
    require(false == tokenIdToUserMinted[tokenId].minted, "Token already minted.");

    tokenIdToUserMinted[tokenId].minted = true;

    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  /**
   * @dev User Mint
   * Anyone can call this function
   */
  function userMint() external payable {
    require(msg.value >= _basePrice, "Not enought Matic sent");
    require(_totalSupply < _maxSupply, "Max supply reached.");

    _totalSupply++;
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();

    UserMinted memory minted = UserMinted(msg.sender, tokenId, false);
    tokenIdToUserMinted[tokenId] = minted;

    emit ToMint(msg.sender, tokenId);
  }

  /**
   * @dev get the token's uri from tokenId
   */
  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }

  /**
   * @dev
   */
  function setTokenURI(uint256 tokenId, string memory _tokenURI) external onlyOwner {
    super._setTokenURI(tokenId, _tokenURI);
  }

  /**
   * @dev
   */
  function getTokenIds(address _owner) public view returns(uint[] memory) {
    uint[] memory _tokensOfOwner = new uint[](ERC721.balanceOf(_owner));

    for (uint i = 0; i < ERC721.balanceOf(_owner); i++) {
      _tokensOfOwner[i] = ERC721Enumerable.tokenOfOwnerByIndex(_owner, i);
    }

    return _tokensOfOwner;
  }

  /**
   * @dev
   */
  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
    internal
    override(ERC721, ERC721Enumerable, ERC721Pausable)
  {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  /**
   * @dev Pause the contract, only admin role can pause
   */
  function pause() public onlyOwner {
    _pause();
  }

  /**
   * @dev Unpause the contract, only admin role can unpause
   */
  function unpause() public onlyOwner {
    _unpause();
  }

  /**
   * @dev Burn a token using it's id, only admin role can burn a token
   */
  function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) onlyOwner {
    super._burn(tokenId);
  }

 /**
  * @dev See {IERC165-supportsInterface}.
  */
  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable, AccessControlEnumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}