// SPDX-License-Identifier: MIT
        
pragma solidity ^0.8.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../project1.0/Agreement1.0.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite is Agreement {
    // Agreement agreement;
    address acc0 = TestsAccounts.getAccount(1);
    string  _operation = "choice CSC8113";

    uint256 user1_Id = 0;
    bool user1_consent = true;
    string[] user1_processedData = ["c1234567", "Mike", "Advanced Computer Science"];

    uint256 user2_Id = 1;
    bool user2_consent = false;
    string[] user2_processedData = ["c7654321", "Lucy", "Cloud Computing"];

    VoteData user1;
    VoteData user2;
    
    // This function is called before each test function
    function beforeEach() public {
        // agreement = new Agreement();
        acc0 = TestsAccounts.getAccount(1);
        user1 = VoteData(acc0, user1_Id, user1_consent, _operation, user1_processedData);
        user2 = VoteData(acc0, user2_Id, user2_consent, _operation, user2_processedData);
    }

    function user1Agreementcheck() public {
        addVote(acc0, user1_Id, user1_consent, _operation, user1_processedData);
        Assert.equal(address(this), TestsAccounts.getAccount(1), "Invalid sender");
        VoteData memory user1_votedata = getVoteInfobyIndex(user1_Id);
        Assert.equal(user1_votedata.userId, user1_Id, "user1 push into list");
    }
}
    