// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.5.0/security/Pausable.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

contract SMCREATIVE is ERC721, ERC721Enumerable, Pausable, Ownable {
   
   //=======1.PROPERTY VARIABLES======//
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    //defining mint price of 0,05 ether for each token
    uint256 public MINT_PRICE=0.05 ether;

    //defining maximun supply of all tokens-MAX SUPPL IS 1000 UNIQUE NFTS
    uint256 public MAX_SUPPLY=1000;

    //=====2.LIFECYCLES METHODS=====//

    constructor() ERC721("SMCREATIVE", "SMC") {
        //incrementing token counter
        //starting token id at 1
        _tokenIdCounter.increment();
    }

   // function _baseURI() internal pure override returns (string memory) {
     //   return "ipfs://happyMonkeyBaseURI";
   // }

 //this is a function only owner can call and withdraw all amount from the account
   function withdraw() public onlyOwner(){
       require( address (this).balance > 0,"Balance is 0 no amount to withdraw");
       payable(owner()).transfer(address(this).balance);
   }

    //=====3.PAUSABLE FUNCTION=====//

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
//=====4.MINTING FUNCTION=====//
//  function safeMint(address to) public onlyOwner--.REMOVED THE ONLY OWNER MODIFIER SO THAT IT CAN BE MODIFIED BY ANYONE
    function safeMint(address to) public payable {
        require(totalSupply() < MAX_SUPPLY,"NO TOKENS AVAILABLE");
        require(msg.value >= MINT_PRICE,"NOT ENOUGH ETHER SENT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }


//=====5.OTHER FUNCTION=====//


function _baseURI() internal pure override returns (string memory) {
        return "ipfs://happyMonkeyBaseURI/";
    }
 function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
//NOTES:
//when a contract is deployed it get its own unique address
