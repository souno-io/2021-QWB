pragma solidity ^0.4.23;

contract Test {

    address public owner;
    uint randomnumber = RN;

    constructor() payable {}

    function SetOwner_RN(address addr) public {
        owner = addr;
    }

    function Solved_RN() public {
        if (owner == msg.sender) {
            msg.sender.transfer(address(this).balance);
        }
    }
}