// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../project2.0/Agreement2.0.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    Agreement agreement;
    bytes32 hashAddress = 0xff2fa982629f0c11e86777e54386d281b32b50531195b857bcba3bdaea87638c;
    uint blocknumber = 285;

    function beforeAll() public {
        agreement = new Agreement();
    }

    function AddAgreementTest() public {
        agreement.addVote(hashAddress, blocknumber,TestsAccounts.getAccount(1), true);

        Agreement.VoteData[] memory myvote = agreement.getVoteInfo();
        Assert.equal(myvote.length, 1, "Vote data should be added");
        Assert.equal(myvote[0].hashAddress, hashAddress, "Hash Address should be added");
        Assert.equal(myvote[0].blockNumber, blocknumber, "Blocknumber should be added");
        Assert.equal(myvote[0].userId, TestsAccounts.getAccount(1), "User Id should be added");
        Assert.equal(myvote[0].consent, true, "Constent should be added");
    }

}
    