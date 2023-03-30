// @ts-ignore
import hre from 'hardhat';
// @ts-ignore
import {Framework} from '@superfluid-finance/sdk-core';
const {ethers} = require('hardhat');
require('dotenv').config();
const MoneyRouterABI = require('../artifacts/contracts/MoneyRouter.sol/MoneyRouter.json')
  .abi;

//to run this script:
//1) Make sure you've created your own .env file
//2) Make sure that you have your network and accounts specified in hardhat.config.js
//3) Make sure that you add the address of your own money router contract
//4) Make sure that you change the 'amount' field in the moneyRouterApproval operation to reflect the proper amount
//3) run: npx hardhat run scripts/tokenApproval.js --network goerli
async function mainApproval() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  //NOTE - make sure you add the address of the previously deployed money router contract on your network
  const moneyRouterAddress = '0x7fD6DF6377a490D40aD3555E871DD06F2C290eD0';
  const treasuryAddress = '0x76d19953cb0af9A514ADA27DBaAed5d5D1969803';

  const provider = new hre.ethers.providers.JsonRpcProvider(
    process.env.MUMBAI_URL,
  );

  const sf = await Framework.create({
    chainId: (await provider.getNetwork()).chainId,
    provider,
  });

  // const signers = await hre.ethers.getSigners();
  const signer = new ethers.Wallet(process.env.PRIVATE_KEY_MUMBAI, provider);

  const moneyRouter = new ethers.Contract(
    moneyRouterAddress,
    MoneyRouterABI,
    provider,
  );

  const splashx = await sf.loadSuperToken(
    '0x5B381AE793d02f728952b82F941CaFA52411F6AD',
  );

  //approve contract to spend 1000,000 splashx
  const moneyRouterApproval = splashx.approve({
    receiver: moneyRouter.address,
    amount: ethers.utils.parseEther('1000000'),
  });

  await moneyRouterApproval.exec(signer).then(function(tx: any) {
    console.log(`
        Congrats! You've just successfully approved the money router contract. 
        Tx Hash: ${tx.hash}
    `);
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
mainApproval().catch(error => {
  console.error(error);
  process.exitCode = 1;
});
