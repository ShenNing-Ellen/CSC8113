// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "./Log.sol";

contract DataUsageContract {
    LogContract logs;
    struct DataUsage {
        address actorId;
        string serviceName;
        string servicePurpose;
        string operation;
        string[] personalData;
    }
    
    DataUsage[] private dataUsages;
    bytes32 _blockHash;
    mapping(address => DataUsage) MappingdataUsages;

    function addDataUsage(
        address actorId,
        string memory serviceName,
        string memory servicePurpose,
        string memory operation,
        string[] memory personalData
    ) public {
        dataUsages.push(DataUsage(actorId, serviceName, servicePurpose, operation, personalData));
        logs.logDataProcessed(actorId,operation,personalData,serviceName);
        // MappingdataUsages[msg.sender].actorId = actorId;
        // MappingdataUsages[msg.sender].serviceName = serviceName;
        // MappingdataUsages[msg.sender].servicePurpose = servicePurpose;
        // MappingdataUsages[msg.sender].operation = operation;
        // MappingdataUsages[msg.sender].personalData = personalData;
    }

    // function getDataUsagebyAddress(address _address) public view returns (DataUsage memory) {
    //     return MappingdataUsages[_address];
    // }
    
    function getDataUsageCount() public view returns (uint256) {
        return dataUsages.length;
    }
    
    function getDataUsage(uint256 index) public view returns (
        address actorId,
        string memory serviceName,
        string memory servicePurpose,
        string memory operation,
        string[] memory personalData
    ) {
        require(index < dataUsages.length, "Data usage index out of range");
        DataUsage storage dataUsage = dataUsages[index];
        // DataUsageContract.getCurrentBlockHash();
        return (dataUsage.actorId, dataUsage.serviceName, dataUsage.servicePurpose, dataUsage.operation, dataUsage.personalData);
    }

    function getCurrentBlockHash() public view returns(bytes32) {
        return blockhash(block.number);
    }

}
