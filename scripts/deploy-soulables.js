
async function main() {
  const Soulables = await ethers.getContractFactory('Soulables')
  const soulables = await Soulables.deploy()
  await soulables.deployed()
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });