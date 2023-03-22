// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Data usage smart contract: It stores the purpose of processing of users data that
// involves assigning values to these parameters: “actor ID”, “service name”, “service
// purpose”, “operation” and “list of personal data”.

//import "./Log.sol";

contract DataUsage{
   // Log logs;
    struct DataPurpose {
        address actorID;
        string serviceName;
        string servicePurpose;
        uint256 operation;//输入操作等级，1级操作：只读，2级操作：读、写 ， 3级操作：读、写、传输  ...
        string[] personalData;//(name, addresss, ID,telephone,HB,BP,UL)
    }
    // DataPurpose's struct public anArray;
    DataPurpose[] public dataPurposes;

    // 优化映射，blockNumber =>DataPurpose[]
    //block.number =>  映射   操作
    mapping (uint256=>DataPurpose) blockNumberToDataPurpose;


    event log(string message,uint256 number);

    function addDataPurpose(
        address _actorID,
        string memory _serviceName, 
        string memory _servicePurpose, 
        uint256  _operation, 
        string[] memory _personalData ) public  {
            dataPurposes.push(DataPurpose(_actorID,_serviceName,_servicePurpose,_operation,_personalData));
            blockNumberToDataPurpose[block.number] = dataPurposes[dataPurposes.length -1];
            emit log("------blocknumber----------", block.number);
    }
    
    //通过block.number 得到对应的操作
    function getOperByBlockNumber(uint256 _blockNumber) public view  returns (uint256){
        return blockNumberToDataPurpose[_blockNumber].operation;
    }

    //通过block.number 得到对应的acotroId
    function getActorByBlockNumber(uint256 _blockNumber) public view  returns (address){
        return blockNumberToDataPurpose[_blockNumber].actorID;
    }

      //通过block.number 得到对应的personalData
    function getPerDataByBlockNumber(uint256 _blockNumber) public view  returns (string[] memory){
        return blockNumberToDataPurpose[_blockNumber].personalData;
    }
    // 用于unit test
    function getAllDataPurpose() public view returns(DataPurpose[] memory){
        return dataPurposes;
    }
}