import axios from 'axios'
import { createAlchemyWeb3 } from '@alch/alchemy-web3'

export default function handler(req, res) {
  const web3 = createAlchemyWeb3(process.env.ALCHEMY_API)
  res.status(200).json({ test: 'soulables' })

  // json
}
