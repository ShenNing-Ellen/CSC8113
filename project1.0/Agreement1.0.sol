// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Agreement {

//
    struct VoteData {
        //bytes32 hashAddress;//存储的是DataUsage的用户处理目的的hash地址
        address actorId;
        uint256 userId;
        bool consent;
        string  operation;
        string[] processedData;
    }

    VoteData[] public voteDatas;

    //mapping(bytes32 => mapping(string => mapping(uint256 => bool))) myMapping;

    //设置操作映射  操作 => userId => consent 映射

    //设置映射 个人数据 => userId => consent 映射

    //添加用户投票
    function addVote(
        //bytes32 _hashAddress,
        address _actorId,
        uint256 _userId,
        bool _consent,
        string memory  _operation,
        string[] memory _processedData) public {

        voteDatas.push(VoteData(_actorId,_userId,_consent,_operation,_processedData));
    }

    //得到所有的Vote 数据
    function getVoteInfo() public view returns (VoteData[] memory ) {
        return voteDatas;
    }

    
    //得到所有单个log
    function getVoteInfobyIndex(uint256 _index) public view returns (VoteData memory ) {
        return voteDatas[_index];
    }


}
