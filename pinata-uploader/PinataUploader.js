const axios = require('axios');
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(process.env.pinata_api_key, process.env.pinata_secret_api_key);
require('dotenv').config()

export const testAuthentication = () => {
    const url = `https://api.pinata.cloud/data/testAuthentication`;
    return axios
      .get(url, {
        headers: {
          pinata_api_key: process.env.pinata_api_key,
          pinata_secret_api_key: process.env.pinata_secret_api_key
        }
      })
      .then(function (response) {
          //handle your response here
      })
      .catch(function (error) {
          //handle error here
      });
};