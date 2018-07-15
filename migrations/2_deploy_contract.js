const RSP= artifacts.require("./RockStonePaper.sol")

module.exports = function(deployer) {
	deployer.deploy(RSP);
};