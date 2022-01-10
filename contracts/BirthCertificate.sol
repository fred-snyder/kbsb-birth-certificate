// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/// @title A digital birth certificate for Kaboom Shebang
/// @author Fred Snyder (Kaboom Shebang)
/// @notice The contract includes a challenge: publish 60-articles in 5-years
/// @custom:url https://www.kaboomshebang.com

contract BirthCertificate {

	/// @notice The address of the contract owner
	address owner;

	/// @notice The state of the 5-year challenge
	bool public challengeSuccess;
	uint public contractEndDate;
	
	struct Cert {
		string name;
		uint birthDate;
		string planet;
		string country;
		string city;
		string url;
	}

	Cert public kbsbCert;

	constructor () {
		owner = msg.sender;
		contractEndDate = 1799539261; // Sunday, 10 January 2027 00:00:00

		kbsbCert.name = "Kaboom Shebang";
		kbsbCert.birthDate = block.timestamp;
		kbsbCert.planet = "Earth";
		kbsbCert.country = "The Netherlands";
		kbsbCert.city = "Amsterdam";
		kbsbCert.url = "https://www.kaboomshebang.com";
	}

	/// @notice Process the challenge
	/// @param articles The number of articles published on kaboomshebang.com
	/// @return A string with the success status of the contract
	function success(uint8 articles) public returns (string memory) {
        require(msg.sender == owner, "Sorry, only the contract owner can update.");

		/// @custom:conditions Check for 
		if (block.timestamp > contractEndDate && articles >= 60) {
			challengeSuccess = true;
			return "Congratulations, mission accomplished!";
		} else if (block.timestamp < contractEndDate) {
			return "The contract term has not yet expired.";
		} else {
			challengeSuccess = false;
			return "Your mission is a failure.";
		}
	}

	function printCertificate() public view returns (Cert memory) {
		return kbsbCert;
	}

	function printChallengeSuccesState() public view returns (bool) {
		return challengeSuccess;
	}

	function printContractEndUnixDate() public view returns (uint) {
		return contractEndDate;
	}
}
