// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Agreement {

//
    struct VoteData {
        bytes32 hashAddress;//存储的是DataUsage的用户处理目的的hash地址,可以通过blockHash(block.number)方法自动获取
        uint256 blockNumber; // 存入DataUsage每次交易数据的BlockNumber，与hashAddress相同意义，具有唯一性
        address userId;
        bool consent;
    }

    VoteData[] public voteDatas;

    //添加用户投票, test uint专用
    function addVote(
        bytes32 _hashAddress,
        uint256 _blockNumber,
        address _userId,
        bool _consent
       ) public {
           //需要优化，自动生成hash 通过blocknumber ---------- 已优化
        voteDatas.push(VoteData(_hashAddress,_blockNumber,_userId,_consent));
    }

    //得到所有的Vote 数据
    function getVoteInfo() public view returns (VoteData[] memory ) {
        return voteDatas;
    }

    //得到所有单个vote
    function getVoteInfobyIndex(uint256 _index) public view returns (VoteData memory ) {
        return voteDatas[_index];
    }
   
    //验证 是否可以通过blockNUmber得到 区块 hash
    // event hash(string message,bytes32 hash);
    // function getHash(uint256 blockNumber) public  returns (bytes32) {
    //     emit hash("-----------hash--------------", blockhash(blockNumber));
    //     return blockhash(blockNumber);  
    // }


}
