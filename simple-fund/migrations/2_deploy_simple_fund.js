var FundCreator = artifacts.require('FundCreator');

module.exports = function (deployer) {
  deployer.deploy(FundCreator);
};
