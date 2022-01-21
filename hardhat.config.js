require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

const projectId = process.env.ALCHEMY_PROJECT_ID_RINKEBY;
const privateKey = process.env.DEPLOYER_SIGNER_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/${projectId}`,
      accounts: [privateKey],
    },
  },
};
