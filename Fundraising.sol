pragma solidity ^0.4.18;
  contract example {
    address public organizer;
    address public charity;
    string public organizerName;
    string public charityName;
    uint public startTime;
    struct sponsor{
      address sponsorAddress;
      uint sponsorMoney;
      uint sponsorTime;
    }
    mapping (address=>sponsor) public sponsors;
    modifier onlyOrganizer{
      require(msg.sender == organizer);
      _;}
    function example(string _organizerName , string _charityName , address _charity)  public{
      organizer = msg.sender;
      charity = _charity;
      organizerName = _organizerName;
      charityName = _charityName;
      startTime = now;
      }
    function donate() payable public{
      sponsors[msg.sender] =sponsor({
          sponsorAddress :msg.sender ,
          sponsorMoney : msg.value,
          sponsorTime : now
        });
    }
    function sendMoney() onlyOrganizer  public {
      charity.transfer(this.balance);
    }
  }
