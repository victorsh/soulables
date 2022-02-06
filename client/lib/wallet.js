import {ethers} from 'ethers'

export const connectWallet = async () => {
  const provider = new ethers.providers.Web3Provider(
    window.ethereum, "any"
  )

  await provider.send("eth_requestAccounts", [])
  const signer = provider.getSigner()
  let userAddress = await signer.getAddress()
  console.log(userAddress)
  let balance = await provider.getBalance(userAddress)
  console.log(balance)
  // let mySig = await signer.signMessage('Signed NFTAuth')
  // console.log(mySig)
  return { userAddr: userAddress, userBalance: balance }
}

export const checkMetamaskConnected = async () => {
  const provider = new ethers.providers.Web3Provider(
    window.ethereum, "any"
  )
  const accounts = await provider.listAccounts()
  return accounts.length > 0
}

export const checkNetwork = async () => {
  const provider = new ethers.providers.Web3Provider(
    window.ethereum, "any"
  )
  const { chainId } = await provider.getNetwork()
  return chainId === 80001
}

export const getOwnedTokens = async () => {
  const provider = new ethers.providers.Web3Provider(
    window.ethereum, "any"
  )
  const signer = await provider.getSigner()
  let userAddr = await signer.getAddress()
  const AuthNFTContract = new ethers.Contract(AuthNFTAddr.addr, nftAuthAbi.abi, signer)

  let tx = await AuthNFTContract.getTokenIds(userAddr)
  let tokenContent = []

  for (const tid of tx) {
    let tx2 = await AuthNFTContract.getTokenContent(Number(tid.toString()))
    const content = {
      id: Number(tid.toString()),
      text: tx2[0],
      special: tx2[1].toString(),
      random: tx2[2].toString(),
      permission: tx2[3]
    }
    tokenContent.push(content)
  }
  return tokenContent
}