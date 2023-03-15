// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogContract {
    event DataProcessed(
        address indexed actorId,
        string indexed operation,
        string[] indexed personalData,
        string serviceName
    );
    
    function logDataProcessed(
        address actorId,
        string memory operation,
        string[] memory personalData,
        string memory serviceName
    ) public {
        emit DataProcessed(actorId, operation, personalData, serviceName);
    }
}
