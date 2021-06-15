pragma solidity 0.4.23;

contract Test {
    
    constructor() payable {}

    function test_RN() public payable {
        if(msg.value > 1 wei) {
            msg.sender.transfer(address(this).balance);
        }
    }
}