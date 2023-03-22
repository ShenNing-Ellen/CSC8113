// SPDX-License-Identifier: GPL-3.0
        
pragma solidity ^0.8.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../project2.0/Verification2.0.sol";
import "../project2.0/Agreement2.0.sol";
import "../project2.0/Log2.0.sol";
import "../project2.0/DataUsage2.0.sol";
// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    Verification public myverification;
    DataUsage private dataUsage;
    Agreement private userAgreement;
    Log private logs;
    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        myverification = new Verification();
    }

    function TestVerification() public {

        address  CurrUsageAddr;
        address  CurrAgreeAddr;
        address  CurrLogAddr;

        string memory serviceName = "Test service";
        string memory servicePurpose = "Test data usage";
        string[] memory personalData = new string[](2);
        uint256 operation = 2;
        personalData[0] = "Name";
        personalData[1] = "Email";
        dataUsage.addDataPurpose(TestsAccounts.getAccount(1), serviceName, servicePurpose, operation, personalData);
        CurrUsageAddr = address(dataUsage);

        uint256 blocknumber = block.number;
        userAgreement.addVote(blockhash(blocknumber),blocknumber,TestsAccounts.getAccount(2), true);
        CurrAgreeAddr = address(userAgreement);

        logs.addLog(TestsAccounts.getAccount(1), operation, personalData, serviceName);
        CurrLogAddr = address(logs);

        myverification.uodateAddress(CurrUsageAddr,CurrAgreeAddr,CurrLogAddr);

        myverification.verification();
    }
}
    