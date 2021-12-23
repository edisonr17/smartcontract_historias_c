const HistoriasContract = artifacts.require("HistoriasContract");

module.exports = function (deployer) {
  deployer.deploy(HistoriasContract);
};
