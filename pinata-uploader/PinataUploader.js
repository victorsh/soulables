const axios = require('axios');
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(process.env.pinata_api_key, process.env.pinata_secret_api_key);
require('dotenv').config()

const testAuthentication = async () => {
  const url = `https://api.pinata.cloud/data/testAuthentication`;

  let res = await axios.get(url, {
      headers: {
        pinata_api_key: process.env.pinata_api_key,
        pinata_secret_api_key: process.env.pinata_api_secret
      }
    })
  console.log(res.data)
};

testAuthentication()