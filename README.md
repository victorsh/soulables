# Soulables
A collections of souls

---

## **Setup Blockchain**
- Add your `ETH Private Key` to `.env`
- `npm i`

Running the deploy script with copy the contract's deployed address and the contracts ABI into the client.

- deploy-local
  - Start a local instance of blockchain node: `npx hardhat node`
  - `npx hardhat run --network localhost scripts/deploy-soulables.js`

- deploy-mumbai
  - `npx hardhat run --network mumbai scripts/deploy-soulables.js`

- `npm run dev`
---

## **Setup Client**

**MongoDB Local**

- OSX MongoDB Local
  - `brew tap mongodb/brew`
  - `brew install mongodb-community@5.0`

- Start/Stop MongoDB Local
  - `brew services start mongodb-community@5.0`
  - `brew services stop mongodb-community@5.0`

- `mongosh` - copy `connecting to:` into `.env.local`

**Alchemy**
- Setup Account
  - https://www.alchemy.com/
  - Create node polygon mumbai 
---

## **Piñata Uploader**
https://www.pinata.cloud/

- Setup and account with pinata
- Setup new api credentials
- Add credentials to .env file

---

#### **Hardhat Starter**

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

#### **Sources**
[Tailwind PreBuilt](https://wallis.dev/blog/5-places-to-get-free-tailwind-css-components)<br />
[Piñata](https://www.pinata.cloud/)<br />
[Alchemy](https://www.alchemy.com/)<br />