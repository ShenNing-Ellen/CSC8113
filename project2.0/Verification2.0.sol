// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DataUsage2.0.sol";
import "./Agreement2.0.sol";
import "./Log2.0.sol";
contract Verification {

    //设置参数
    //DataUsage[] actors;
    //DataUsage usage;
    DataUsage private dataUsage;
    Agreement private userAgreement;
    Log private logs;

    address[]  vioActor;
    
    //event 打印log;
    event PrintLog1(string message, Log.LogInfo[] logInfos);
    event PrintLog2(string message, Agreement.VoteData[] logInfos);
    event PrintLog3(string message);
    event PrintLog4(string message,address actorId);
    event PrintLog5(string message,uint i);
    event PrintLog6(string message,string[],string[]);

    address  CurrAgreeAddr ;
    address  CurrLogAddr ;
    address  CurrUsageAddr ;

    //更新地址 函数 扩展性优化
    function uodateAddress(address _usageAddr,address _agreeAddr,address _logAddr ) public {
        if(CurrAgreeAddr != _agreeAddr){CurrAgreeAddr = _agreeAddr;}
        if (CurrLogAddr != _logAddr){CurrLogAddr = _logAddr;}
        if (CurrUsageAddr != _usageAddr){CurrUsageAddr = _usageAddr;}
    }

    //三个层面核查
    function verification() public  returns (address[] memory){
        dataUsage = DataUsage(CurrUsageAddr);
        userAgreement = Agreement(CurrAgreeAddr); 
        logs = Log(CurrLogAddr);
 
        emit PrintLog3("Gei");
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

            //得到DataUsage的actorID 存储actorID 减少重复跨合约调用
            address  dataUasgeActorId = dataUsage.getActorByBlockNumber(veriVote.blockNumber);

            //当用户 不同意时: log记录了dataUsage真实操作，log里面存在这个操作，说明actor违规，则会被记录为违规者
            if(!con){
                vioActor.push(dataUasgeActorId); 
                continue;
            }else { 
                //当用户同意时, 行为人，操作，数据列表三个层面进行判断是否违规
                emit PrintLog3("catch Un consent record");
                //验证1：日志记录的行为人是否符合 与同意合约的行为人是否相符
                if(veriLog.actorId != dataUasgeActorId){
                    emit PrintLog4("Catch actor error",dataUasgeActorId);//日志打印
                    vioActor.push(dataUasgeActorId);
                    continue;
                }else if( veriLog.operation > dataUsage.getOperByBlockNumber(veriVote.blockNumber) ){
                    //验证2：比对 操作是否相符 ,若DataUsage操作的等级底于Log中的操作等级,则判定违规
                    emit PrintLog4("Catch operation error",dataUasgeActorId);//日志打印
                    vioActor.push(dataUasgeActorId); 
                    continue;
                }else if(!isSubset(veriLog.personalData,dataUsage.getPerDataByBlockNumber(veriVote.blockNumber))){
                    //验证3：比对 个人数据是否相符,通过子集判断  datausage的个人数据列表作为父集，log记录Actor的真实操作的个人数据列表作为子集   
                    emit PrintLog4("Catch processedData  error",dataUasgeActorId);//日志打印
                    vioActor.push(dataUasgeActorId);
                    continue;
                }
            }
        }
        return vioActor;
    }




    //判断数组子集
    function isSubset(string[] memory _subset, string[] memory _fatherSet) private   pure returns(bool){
        for(uint256 i=0; i<_subset.length; i++ ){
            bool isSub = false;
            for(uint256 j=0; j<_fatherSet.length;j++){
                if(keccak256(bytes(_subset[i])) == keccak256(bytes(_fatherSet[j]))){
                    isSub = true; break;
                }
            }
            if(!isSub){
                return false;
            }
        }
        return true;
    }  

    //hash
    // 得到vioActor值
    function getVioActor() public view returns (address[] memory ){
        return vioActor;
    }

    

}



        



