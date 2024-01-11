/// Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/**
* @title ERC721 token for GGDAO
* @author Aoi Nakamoto. 
*/
contract GGDAO is ERC721URIStorage, Ownable{
    string constant BASE_URI = "https://gateway.pinata.cloud/ipfs/";
    string constant CHANGE = "QmWECq67oZu89h9QBAzbk3DFRMgy6RTtZ16P9fpqtedVHW";
    string constant CHAMPION = "QmdQKLaWYh1Z8HbcFhkAcnpRUaUcMbeZKLMEgU8DEZgKA5";
    string constant PEACE = "QmcwsJsFrofAyXDXVKrRQqncKi6qA99ZDbT35u51Psffkx";
    string constant VISIONARY = "QmTVRP4rShXTF1xpfNeo9ovdxMfcEJpz4uA7CBcjC4ScnM";
    string constant GUARDIAN = "QmSKY7fuhFc29U7wUCVTndds2NU4NtZHQfqAajrXbd9s8B";
    string constant LUMINARY = "QmcZQfwejvBJF6ZxgNRiEsvGifxfMQ9JCV3jsKJ9VVxi9n";
    string constant GENESIS = "QmUMzzaA22s2vTD5Nsd9pdbweKCjEfHMMwhK8PxJuJFqgF";

    uint256 constant VAL_CHANGE = 0.01 ether;
    uint256 constant VAL_CHAMPION = 0.1 ether;
    uint256 constant VAL_PEACE = 1 ether;
    uint256 constant VAL_VISIONARY = 10 ether;
    uint256 constant VAL_GUARDIAN = 100 ether;

    using Counters for Counters.Counter;
    Counters.Counter private tokenId;

    address TREASURY_WALLET = 0x69E796DF6D3Ddf048750754D663b9d3384370296;

    event NewTokenMinted (
        address indexed newTokenOwner,
        uint256 indexed itemId
    );

    event TreasuryWalletChanged(
        address indexed previousWallet,
        address indexed neWallet
    );

    constructor () ERC721 ("The UDHR NFT", "UDHRNFT") {
        _mint(TREASURY_WALLET, tokenId.current());
        _setTokenURI(tokenId.current(), string(abi.encodePacked(BASE_URI, GENESIS)));
    }

    /**
     *  Returns the address of the current wallet.
     */
    function treasury() public view returns (address) {
        return TREASURY_WALLET;
    }

    /**
    * Unlimited minting for anyone, deposits donating money to the dao wallet.
    * Mints new NFT with tokenId & Address, also creates 
    * new metadata for that NFT.
    * Deposit donated money to treasury wallet.
    */
    function mintNFT() public payable {
        uint256 value = msg.value;
        string memory donorLevel;

        if(value < VAL_CHANGE) 
            donorLevel = CHANGE;
        else if(value >= VAL_CHANGE && value < VAL_CHAMPION) 
            donorLevel = CHAMPION;
        else if(value >= VAL_CHAMPION && value < VAL_PEACE) 
            donorLevel = PEACE;
        else if(value >= VAL_PEACE && value < VAL_VISIONARY) 
            donorLevel = VISIONARY;
        else if(value >= VAL_VISIONARY && value < VAL_GUARDIAN) 
            donorLevel = GUARDIAN;
        else if(value >= VAL_GUARDIAN) 
            donorLevel = LUMINARY;

        /// Deposits donated money to treasury wallet.
        payable(TREASURY_WALLET).transfer(value);
        tokenId.increment();
        uint256 newItemId = tokenId.current();

        /// Mints a new token.
        _mint(_msgSender(), newItemId);
        _setTokenURI(newItemId, string(abi.encodePacked(BASE_URI, donorLevel)));
        emit NewTokenMinted(_msgSender(), newItemId);
    }

    /**
    * Changes current treasury wallet to a new wallet (`neWallet`).
    * Can only be called by the current owner.
    */
    function changeTreasuryWallet(address neWallet) public onlyOwner {
        require(neWallet != address(0), "Ownable: new owner is the zero address");
        address oldWallet = TREASURY_WALLET;
        TREASURY_WALLET = neWallet;
        emit TreasuryWalletChanged(oldWallet, neWallet);
    }
}
