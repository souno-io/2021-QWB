pragma solidity ^0.4.23;

contract Test {

    address public owner;
    uint randomnumber = RN;
    
    constructor() payable {}

    function SetOwner_RN(address addr) public {
        owner = addr;
    }
    
    function withdraw_RN(uint key){ 

        require (owner == msg.sender);
        
        if(key^0xcafebab1 == pika_key){
            msg.sender.transfer(address(this).balance);
        }
    }
}