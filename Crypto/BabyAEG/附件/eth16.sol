pragma solidity ^0.4.23;

contract Test {

    uint randomnumber = RN;
    
    constructor() payable {}
    
    function withdraw_RN(address to, uint key){ 
        if(key^0xcafebabc == pika_key){
            to.transfer(address(this).balance);
        }
    }
}