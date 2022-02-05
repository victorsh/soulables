# Soulables
A collections of souls

#### Setup Blockchain
Add your ETH private key to .env
npm i

deploy-local: `npx hardhat run --network localhost scripts/deploy-soulables.js`<br>
deploy-mumbai: `npx hardhat run --network mumbai scripts/deploy-soulables.js`

#### Setup Client

brew tap mongodb/brew
brew install mongodb-community@5.0

brew services start mongodb-community@5.0
brew services stop mongodb-community@5.0

`mongosh` - copy connecting to: into .env.local

#### Harhat Starter

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
