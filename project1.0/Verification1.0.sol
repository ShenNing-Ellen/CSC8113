// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DataUsage1.0.sol";
import "./Agreement1.0.sol";
import "./Log1.0.sol";
contract Verification {

    //设置参数
    //DataUsage[] actors;
    //DataUsage usage;
    Agreement private userAgreement;
    Log private logs;

    address[]  vioActor;
    
    //event 打印log;
    event PrintLog1(string message, Log.LogInfo[] logInfos);
    event PrintLog2(string message, Agreement.VoteData[] logInfos);
    event PrintLog3(string message);
    event PrintLog4(string message,address actorId);

    //设置合约地址，通过构造器方式
    constructor(){
       userAgreement = Agreement(0x406AB5033423Dcb6391Ac9eEEad73294FA82Cfbc); 
       logs = Log(0x93f8dddd876c7dBE3323723500e83E202A7C96CC); 
    }

    //日志智能合约所记录的行为人是否符合 与用户通过协议同意的行为人是否
    function verification() public  returns (address[] memory){
        // emit PrintLog3("Gei");
        //得到所有的log数据
        Log.LogInfo[] memory logInfos = logs.getLogInfo();
        emit PrintLog1("get logInfo",logInfos);//日志打印
        //得到所有的 Vote数据
        Agreement.VoteData[] memory voteInfos =  userAgreement.getVoteInfo();
        emit PrintLog2("get voteInfos", voteInfos);//日志打印

        //循环遍历验证
        for(uint i=0; i<logInfos.length ; i++){
            //bool  flat = true;
            //得到每条Vote信息
            Agreement.VoteData memory veriVote = voteInfos[i];
            //得到该条log信息
            Log.LogInfo memory veriLog = logInfos[i];
            bool con = veriVote.consent;
            //只验证没有获得积极同意的log 
            if(!con){
                emit PrintLog3("catch Un consent record");
                //验证1：日志记录的行为人是否符合 与同意合约的行为人是否相符
                if(veriLog.actorId !=  veriVote.actorId ){
                    emit PrintLog4("Catch actor error",veriLog.actorId);//日志打印
                    //flat = false;
                    vioActor.push(veriLog.actorId);
                    continue;
                }else if(keccak256(abi.encodePacked(veriLog.operation)) != keccak256(abi.encodePacked(veriVote.operation))){
                    //验证2：比对 操作是否相符
                    emit PrintLog4("Catch operation error",veriLog.actorId);//日志打印
                    //flat = false;
                    vioActor.push(veriLog.actorId); 
                    continue;
                }else if(veriLog.processedData.length != veriVote.processedData.length){
                    emit PrintLog4("Catch processedData Length error",veriLog.actorId);//日志打印
                    //验证3：比对 个人数据是否相符
                    //flat = false;
                    vioActor.push(veriLog.actorId);
                    continue;
                }else if(veriLog.processedData.length == veriVote.processedData.length){
                    ////验证3：比对 个人数据 是否 相符
                    for (uint j = 0; j < veriLog.processedData.length; j++) {
                        if (keccak256(abi.encodePacked(veriLog.processedData[j])) != keccak256(abi.encodePacked(veriVote.processedData[j]))) {
                            emit PrintLog4("Catch processedData[] error",veriLog.actorId);//日志打印
                            //flat = false;
                            vioActor.push(veriLog.actorId);
                            continue;
                        }
                    }
                }
            }
            // // 将违规者ID存入vioActor
            // if(!flat){
            //     vioActor.push(veriLog.actorId);
            // }

        }
        return vioActor;
    }

    // 得到vioActor值
    function getVioActor() public view returns (address[] memory ){
        return vioActor;
    }
}



        



