// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogContract {

    struct DataProcess{
        address actorId;
        string operation;
        string[]  personalData;
        string serviceName;
        uint timestamp;
    }
    DataProcess private _dataprocess;
    // mapping(address => DataProcessed) public Logs;
    struct LogByActor {
        // address actorId;
        uint numDataProcess;
        mapping(uint => DataProcess) DataProcesses;
        
    }
    mapping(address => LogByActor) private LogsByActors;
    // DataProcess[] private _dataprocesses;
    
    
    function logDataProcessed(
        address actorId,
        string memory operation,
        string[] memory personalData,
        string memory serviceName
    ) public {
        _dataprocess = DataProcess(actorId, operation, personalData, serviceName, block.timestamp);
        LogsByActors[actorId].DataProcesses[LogsByActors[actorId].numDataProcess] = _dataprocess;
        LogsByActors[actorId].numDataProcess ++;
    }

    function getDataProcessesByActor(address actorId) public view returns (DataProcess[] memory) {
        LogByActor storage log = LogsByActors[actorId];
        DataProcess[] memory result = new DataProcess[](log.numDataProcess);

        for (uint i = 0; i < log.numDataProcess; i++) {
            result[i] = log.DataProcesses[i];
        }
        return result;
    }

}
