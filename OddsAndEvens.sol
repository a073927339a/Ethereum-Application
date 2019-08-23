pragma solidity ^0.4.18;

contract OddsAndEvens{

  struct Player {
    address addr;
    uint number;
  }

  Player[2] public players;         //public only for debug purpose

  uint8 tot;
  address owner;

  function OddsAndEvens () public{
    owner = msg.sender;
  }

  function play(uint number) public payable{
    if (msg.value != 1 ether) revert();

    players[tot] = Player(msg.sender, number);
    tot++;

    if (tot==2) andTheWinnerIs();
  }

  function andTheWinnerIs() private {
    bool res ;
    uint n = players[0].number+players[1].number;
    if (n%2==0) {
      res = players[0].addr.send(1800 finney);
    }
    else {
      res = players[1].addr.send(1800 finney);
    }

    delete players;
    tot=0;
  }

  function getProfit() public{
    if(msg.sender!=owner) revert();
    require(msg.sender.send(this.balance));
  }

}
