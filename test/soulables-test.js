const { expect } = require("chai");
const { ethers } = require("hardhat");

let owner, tx, soulables
const accounts = []

describe("Soulables", function () {
  before(async () => {
    const signers = await ethers.getSigners()
    for (let i = 0; i < 10; i++) {
      accounts.push(signers[i])
    }
    owner = accounts[0]
  })
  describe("Minting", async () => {
    before(async () => {
      const Soulables = await ethers.getContractFactory("Soulables")
      soulables = await Soulables.deploy()
      await soulables.deployed()
    })

    it("should mint a token", async () => {
      const metadataBytes32 = ethers.utils.formatBytes32String('some kinda hash')
      // const hashedMetadata = ethers.utils.sha256(metadataBytes32)
      const uri = 'https://soulables.com/id'
      tx = await soulables.mint(accounts[0].address, uri)
      await tx.wait()

      tx = await soulables.getTokenIds(accounts[0].address)
      tx.forEach(async tid => {
        expect(tid.toString()).to.equal('0')
      })

      tx = await soulables.tokenURI(0)
      expect(uri).to.equal(tx)
    })
  })
});
