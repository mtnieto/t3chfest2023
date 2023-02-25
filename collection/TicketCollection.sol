// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract VampireWeekendTickets is ERC721, ERC721Enumerable, Ownable {
    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    address private MINT_DESTINATION = 0x8c091cfeA36b48F4a5ac022677043601308a521e;  // Mint address owner
    
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        // Minting the tickets when the contract is deployed
        for (uint i = 0; i <= 3; i++){
            _safeMint(MINT_DESTINATION, i);
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeieh2xox4zi7eoc2fabjs4ywasjle62sqkt7ofx7kv2sfpi6ndi3d4/nft/";
    }

    /**
     * @dev See {ERC721-safeMint}.
     */
    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721URIStorage: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool){
        return super.supportsInterface(interfaceId);
    }  
}
