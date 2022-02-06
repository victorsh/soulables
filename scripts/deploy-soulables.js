const fs = require('fs')
const path = require('path')

async function main() {
  const Soulables = await ethers.getContractFactory('Soulables')
  const soulables = await Soulables.deploy()
  await soulables.deployed()

  // Create a file that stores the address of the deployed contract
  const addrObj = { 'addr': soulables.address }
  await fs.writeFileSync(
    path.join(__dirname, '../client/contract/SoulablesAddr.json'), JSON.stringify(addrObj)
  )

  // Copy the ABI of the contract to the client
  const abiFile = await fs.readFileSync(path.join(__dirname, '../artifacts/contracts/Soulables.sol/Soulables.json'), 'utf-8')
  const parsedAbiFile = JSON.parse(abiFile)
  const abiObject = { abi: parsedAbiFile['abi'] }

  await fs.writeFileSync(path.join(__dirname, '../client/contract/SoulablesABI.json'), JSON.stringify(abiObject))
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });