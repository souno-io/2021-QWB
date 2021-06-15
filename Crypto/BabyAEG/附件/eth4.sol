pragma solidity ^0.4.23;

contract Test {

    uint var1;
    uint var2;
    uint var3;
    uint var4;
    address receiver;
    uint randomnumber = RN;

    constructor() payable {}

    function set1_RN(uint new1) public{
        var1 = new1;
    }

    function set2_RN(uint new2) public{
        var2 = new2;
    }

    function set3_RN(uint new3) public{
        var3 = new3;
    }

    function set4_RN(uint new4) public{
        var4 = new4;
    }

    function setreceiver_RN(address newreceiver) public{
        require(var4 == 666);
        receiver = newreceiver;
    }

    function pay_RN() public{
        receiver.transfer(address(this).balance);
    }

}