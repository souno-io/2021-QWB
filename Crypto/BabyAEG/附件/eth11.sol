pragma solidity ^0.4.23;

contract Test {
    
    uint randomnumber = RN;

    constructor() payable {}

    function withdraw_RN(address to) public {
        selfdestruct(to);
    }
}
