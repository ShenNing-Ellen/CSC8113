// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../project2.0/DataUsage2.0.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    DataUsage datausage;
    string serviceName = "Test service";
    string servicePurpose = "Test data usage";

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        datausage = new DataUsage();
    }

    function addDataUsageTest() public{

        string[] memory personalData = new string[](2);
        personalData[0] = "Name";
        personalData[1] = "Email";
        datausage.addDataPurpose(TestsAccounts.getAccount(1), serviceName,servicePurpose, 3, personalData);
        
        DataUsage.DataPurpose[] memory mydata = datausage.getAllDataPurpose();
        Assert.equal(mydata.length, 1, "DataPurpose should be added");
        Assert.equal(mydata[0].actorID, TestsAccounts.getAccount(1), "Actor ID should be correct");
        Assert.equal(mydata[0].serviceName, serviceName, "Actor ID should be correct");
        Assert.equal(mydata[0].operation, 3, "Operation should be correct");
        Assert.equal(mydata[0].personalData.length, 2, "Personal data should be correct");
        Assert.equal(mydata[0].personalData[0], "Name", "Personal data detail should be correct");
        Assert.equal(mydata[0].personalData[1], "Email", "Personal data detail should be correct");
        Assert.equal(mydata[0].servicePurpose, servicePurpose, "Service name should be correct");
    }

    function mapByBlockNumberTest() public {
        string[] memory personalData = new string[](2);
        personalData[0] = "Name";
        personalData[1] = "Phone";
        datausage.addDataPurpose(TestsAccounts.getAccount(1), serviceName,servicePurpose, 2, personalData);
        Assert.equal(datausage.getOperByBlockNumber(block.number), 2, "Operation should be mapped to block number");
        Assert.equal(datausage.getActorByBlockNumber(block.number), TestsAccounts.getAccount(1), "ActorID should be mapped to block number");
        Assert.equal(datausage.getPerDataByBlockNumber(block.number).length, personalData.length, "Personal data should be mapped to block number");
        Assert.equal(datausage.getPerDataByBlockNumber(block.number)[0], "Name", "Personal data detail should be mapped to block number");
        Assert.equal(datausage.getPerDataByBlockNumber(block.number)[1], "Phone", "Personal data detail should be mapped to block number");

    }
}
    