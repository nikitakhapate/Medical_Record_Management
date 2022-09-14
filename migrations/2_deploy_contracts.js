const medical_record_management = artifacts.require("medical_record_management");

module.exports = function(deployer) {
  deployer.deploy(medical_record_management);
};