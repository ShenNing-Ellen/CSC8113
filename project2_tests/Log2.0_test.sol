// SPDX-License-Identifier: GPL-3.0
        
pragma solidity ^0.8.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../project2.0/Log2.0.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite{
    Log logContract;
    

    function beforeEach() public {
        logContract = new Log();
        // mylog = logContract.logs;
    }
    
    function testAddLog() public {
        string[] memory personalData = new string[](2);
        personalData[0] = "Name";
        personalData[1] = "Address";
        
        logContract.addLog(TestsAccounts.getAccount(1), 2, personalData, "Test Service");
        
        Log.LogInfo[] memory logInfos = logContract.getLogInfo();
        
        Assert.equal(logInfos.length, 1, "Log should have 1 entry");
        Assert.equal(logInfos[0].actorId, TestsAccounts.getAccount(1), "Actor ID should match");
        Assert.equal(logInfos[0].operation, 2, "Operation level should match");
        Assert.equal(logInfos[0].personalData.length, 2, "Personal data should have 2 entries");
        Assert.equal(logInfos[0].serviceName, "Test Service", "Service name should match");
    }
    
    function testGetLogInfobyIndex() public {
        string[] memory personalData = new string[](2);
        personalData[0] = "Name";
        personalData[1] = "Email";
        
        logContract.addLog(address(this), 2, personalData, "Test Service");
        
        Log.LogInfo memory logInfo = logContract.getLogInfobyIndex(0);
        
        Assert.equal(logInfo.actorId, address(this), "Actor ID should match");
        Assert.equal(logInfo.operation, 2, "Operation level should match");
        Assert.equal(logInfo.personalData.length, 2, "Personal data should have 2 entries");
        Assert.equal(logInfo.serviceName, "Test Service", "Service name should match");
    }
}
    