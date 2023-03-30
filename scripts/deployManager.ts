import {ethers} from 'hardhat';

async function main() {
  const SuperTokenManager = await ethers.getContractFactory(
    'SuperTokenManager',
  );

  const treasuryAddress = '0x76d19953cb0af9A514ADA27DBaAed5d5D1969803';
  const superTokenManager = await SuperTokenManager.deploy();

  await superTokenManager.deployed();

  console.log(`SuperTokenManager deployed to ${superTokenManager.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});
