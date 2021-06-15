pragma solidity ^0.4.23;

contract Test {

    bool check1 = false;
    bool check2 = false;
    uint randomnumber = RN;

    constructor() payable {}

    function mark_RN(uint choice){
        if(choice == 1){
            check1 = true;
        }else if(choice == 2){
            check2 = true;
        }
    }

    function transfer_RN(address to) {
        require(check1);
        require(check2);
        to.transfer(address(this).balance);
    }
}