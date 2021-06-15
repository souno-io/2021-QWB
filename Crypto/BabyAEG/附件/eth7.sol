pragma solidity 0.4.23;

contract Test {
    bool king = false;

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

    function isKing_RN(address to) public returns (bool){
        require(king);
        to.transfer(address(this).balance);
    }
}