const main = async () => {
  // Compila nuestro contrato, genera archivos necesarios para trabajar con el contrato en el ./artifacts.
  const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
  // Hardhat creará una red Ethereum local solo para este contrato y se destruye al terminar de ejecutar el script.
  const nftContract = await nftContractFactory.deploy();
  // Deploy del contrato
  await nftContract.deployed();
  // nftContract.address es la dirección del contrato desplegado
  console.log("Contract deployed to:", nftContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();