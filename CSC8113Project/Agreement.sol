// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AgreementContract {
    struct Agreement {
        bytes32 purposeHash;
        address userId;
        bool consent;
    }
    
    Agreement[] private agreements;
    
    function addAgreement(bytes32 purposeHash, address userId, bool consent) public {
        agreements.push(Agreement(purposeHash, userId, consent));
    }
    
    function getAgreementCount() public view returns (uint256) {
        return agreements.length;
    }
    
    function getAgreement(uint256 index) public view returns (bytes32 purposeHash, address userId, bool consent) {
        require(index < agreements.length, "Agreement index out of range");
        Agreement storage agreement = agreements[index];
        return (agreement.purposeHash, agreement.userId, agreement.consent);
    }
}
