import {ethers} from 'hardhat';

async function main() {
  const SplashToken = await ethers.getContractFactory('SplashToken');
  const splashToken = await SplashToken.deploy('Splash', 'SPLSH', 100_000_000);

  await splashToken.deployed();

  console.log(`SplashToken deployed to ${splashToken.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});
