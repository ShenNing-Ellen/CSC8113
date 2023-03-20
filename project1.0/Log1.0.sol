// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Log {
    struct LogInfo {
        bytes32 hashAddress;//存储的是DataUsage的用户处理目的的hash地址
        address actorId;
        string operation;//存储了actor在执行时间内对用户数据的个人数据执行了什么操作
        string[] processedData;//被处理的个人数据
        string serviceName;//服务名
    }

    LogInfo[] public  logs;

    //添加log
    function addLog(
        bytes32 _hashAddress,
        address _actorId,
        string memory _operation,
        string[] memory _processedData,
        string memory _serviceName
    )  public {
        logs.push(LogInfo(_hashAddress,_actorId, _operation, _processedData, _serviceName));
    }

    //得到所有log
    function getLogInfo() public view returns (LogInfo[] memory ) {
        return logs;
    }

        //得到所有单个log
    function getLogInfobyIndex(uint256 _index) public view returns (LogInfo memory ) {
        return logs[_index];
    }
    
}

