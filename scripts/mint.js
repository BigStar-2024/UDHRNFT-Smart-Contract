const hre = require("hardhat");
async function main() {
    /**
     * in this example, we impersonate 
     * account address as "0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199".
     * contract address as "0x720472c8ce72c2A2D711333e064ABD3E6BbEAdd3"
     * You can get contract address when deploying smart contract.
     */
    const ACCOUNT_ADDRESS = "0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199";
    const CONTRACT_ADDRESS = "0x720472c8ce72c2A2D711333e064ABD3E6BbEAdd3";
    
    const signer = await ethers.getSigner(ACCOUNT_ADDRESS);
    
    const NFT = await hre.ethers.getContractFactory("GGDAO", signer);
    const contract = NFT.attach(CONTRACT_ADDRESS);
    
    const TREASURY_WALLET = await contract.treasury();
    const treasury = await ethers.getSigner(TREASURY_WALLET);
    console.log("Treasury Address:",treasury.address);
    console.log("Treasury balance:", (await treasury.getBalance()).toString());
    
    console.log("Minting... from:",signer.address);
    console.log("Sender balance:", (await signer.getBalance()).toString());
    console.log("Contract:", contract.address);
    await contract.mintNFT({value: ethers.utils.parseEther("0.1")});
    
    console.log("Treasury balance:", (await treasury.getBalance()).toString());
    console.log("Sender balance:", (await signer.getBalance()).toString());
    console.log("Owned NFTs:", (await contract.balanceOf(signer.address)).toString());
}
main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});