const hre = require("hardhat");
async function main() {
    /**
     * in this example, we impersonate account address as "0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199".
     */
    const ACCOUNT_ADDRESS = "0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199";
    /**
     * CONTRACT_ADDRESS is the deployed smart contract's address;
     */
    const CONTRACT_ADDRESS = "0x720472c8ce72c2A2D711333e064ABD3E6BbEAdd3";

    const signer = await ethers.getSigner(ACCOUNT_ADDRESS);

    const NFT = await hre.ethers.getContractFactory("GGDAO", signer);
    const contract = NFT.attach(CONTRACT_ADDRESS);
    console.log("TO:", contract.address);
    console.log("FROM:",signer.address);

    const res = await contract.tokenURI(5);
    console.log("RESULT:", res);
}
main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});