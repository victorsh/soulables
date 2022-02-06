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
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIdCounter;
  // mapping(uint256 => bytes32) private tokenIdToMetadataHash;

  bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
  bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

  uint256 public _maxSupply = 5555;
  uint256 public _totalSupply;

  /**
   * @dev Sets contract deployer to ADMIN_ROLE
   */
  constructor() ERC721("Soulables", "SLBS") {
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
  }

  /**
   * @dev
   */
  function mint(address to, string memory uri) external payable {
    require(_totalSupply <= _maxSupply, "Max supply reached.");
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  /**
   * @dev
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
  function setTokenURI(uint256 tokenId, string memory _tokenURI) external {
    require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Must have admin role.");
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
  function pause() public {
    require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Must have admin role.");
    _pause();
  }

  /**
   * @dev Unpause the contract, only admin role can unpause
   */
  function unpause() public {
    require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Must haver admin role.");
    _unpause();
  }

  /**
   * @dev Burn a token using it's id, only admin role can burn a token
   */
  function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
    require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Must haver admin role.");
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