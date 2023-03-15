// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SmartWallet{
    address payable owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    constructor() {
        owner = payable(msg.sender);
    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_for] = _amount;
        if(_amount > 0){
            isAllowedToSend[_for] = true;
        }else{
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory) {
        // require(msg.sender == owner, "You are not the owner, aborting!");
        if(msg.sender != owner){
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            allowance[msg.sender] -= _amount;
        }

        // _to.transfer(_amount);
        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Aborting! call was not successful!");
        return returnData;
    }

    receive() external payable {}
}