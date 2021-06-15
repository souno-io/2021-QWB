pragma solidity 0.4.23;

contract Test {
    bool king = false;
    address owner;

    constructor() payable {}

    function setKing_utsgesanbm_RN(uint value) public{
        if (value > 409800) {
            if (value < 409802) {
                king = true;
            }
            else {
                king = false;
            }
        }
    }

    function setOwner_RN(address addr) public {
        owner = addr;
    }

    function isKing_RN() public returns (bool){

        require (owner == msg.sender);
        
        require(king);
        msg.sender.transfer(address(this).balance);
    }
}