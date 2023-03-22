// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Log {
    struct LogInfo {
        address actorId;
        uint256 operation;//定义可操作等级最高限度，1级操作：只读，2级操作：读、写 ， 3级操作：读、写、传输  ...
        string[] personalData;//被处理的个人数据
        string serviceName;//服务名
    }

    LogInfo[] public  logs;

    //添加log
    function addLog(
        address _actorId,
        uint256  _operation,
        string[] memory _personalData,
        string memory _serviceName
    )  public {
        logs.push(LogInfo(_actorId, _operation, _personalData, _serviceName));
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