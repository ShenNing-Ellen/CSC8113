// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Data usage smart contract: It stores the purpose of processing of users data that
// involves assigning values to these parameters: “actor ID”, “service name”, “service
// purpose”, “operation” and “list of personal data”.

// import "./Log1.0.sol";

contract DataUsage{
//    Log logs;
    struct DataPurpose {
        address actorID;
        string serviceName;
        string servicePurpose;
        string operation;//details of the specific service purpose
        string[] personalData;//(e.g., name, addresss, ID,telephone and etc)
    }
    // DataPurpose's struct public anArray;
    DataPurpose[] public dataPurposes;
    //mapping (uint256=>address) actorIDTOAdress;

    function addDataPurpose(
        address _actorID,
        string memory _serviceName, 
        string memory _servicePurpose, 
        string memory _operation, 
        string[] memory _personalData ) public  {
            dataPurposes.push(DataPurpose(_actorID,_serviceName,_servicePurpose,_operation,_personalData));
            // operation.push(_operation);
            // logs.addLog(_actorID, _operation, _personalData, _serviceName);
    }

    //得到所有的DataUsage 
    function getAllDataPurpose() public  view returns(DataPurpose[] memory){
         return dataPurposes;
    }

    //根据索引得到得到DataPurpose 
    function getDataPurpose(uint256 _index) public  view returns(DataPurpose memory){
         return dataPurposes[_index];
    }




}