## About GGDAO.sol
This smart contract does this.
1. When contract is deployed to the blockchain, it first mints NFT for HRDAO(exactly to the treasury wallet).
2. Owner of the smart contract can change the treasury wallet account.
3. Only owner can transfer ownership to the other acount.
4. Has 6 metadatas on pinata for individual UDHRNFTs.(All metadata is stored in metadatas.zip)
5. Unlimited minting is possible.
6. `tokenURI` is stored, so that indicates Metadata uploaded on IPFS, pinata.
7. When minting, money sent on message is deposited into treasuary account.
8. According to the amount of donation, level of donation is awarded to each NFT.
9. Metadata contains 
   - `DonorLevel(change maker, champion, peacekeeper, visionary, guardian, luminary)`,
   - `Issuance Number(tokenId + 1)`,
   - `Symbol: UDHRNFT`,
   - `Name: The UDHR NFT`

## Address/Key used for smart contract.
 1. `TREASURY_WALLET = 0x69E796DF6D3Ddf048750754D663b9d3384370296`
 2. `IPFS Image Address = "https://gateway.pinata.cloud/ipfs/QmQTVLajzcysdEhqLEMtjfbQootQKwHVj3SBoUfDd7JCJ3"`
 3. `API_KEY = "https://mainnet.infura.io/v3/f38eb21f5ad14270bf477f6f9ce80f53"`

## How to compile and deploy/test smart contract
1. Run `npm install`
2. Edit `.env`. If `.env` does not exists, then create new one and then write following code into it.
   - `PRIVATE_KEY = <Your wallet private key>`
   - `API_KEY` = `<https://eth-ropsten.alchemyapi.io/v2/${ALCHEMY_API_KEY}>`
3. Run `npx hardhat run --network mainnet scripts/deploy.js`.
   Using hardhat, it automatically compiles before running scripts.
4. For the test purpose, run
   - `npx hardhat node`
   - `npx hardhat run --network localhost scripts/deploy.js`.
   - You can interact with this test smart contract in another terminal using scripts.
   
