import { Contract, ContractFactory } from "ethers";
import { ethers } from "hardhat";

async function main(): Promise<void> {
  const uniswapRouterMumbai = "0xb71c52BA5E0690A7cE3A0214391F4c03F5cbFB0d";

  const SwapperFactory: ContractFactory = await ethers.getContractFactory("Swapper");
  const swapper: Contract = await SwapperFactory.deploy(uniswapRouterMumbai);
  await swapper.deployed();
  console.log("Swapper deployed to: ", swapper.address);
}

main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
