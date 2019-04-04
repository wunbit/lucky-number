// Solidity version
pragma solidity ^0.5.7;

// Contracts
contract Ownable {
  address payable owner;

  constructor() public {
    // Sets the owner of Contract
    owner = msg.sender;
  }

  // Access modifier
  modifier Owned {
    require (msg.sender == owner);
    _;
  }
}

contract Mortal is Ownable {
  // Our access modifier is present, only the contract creator can use this function
  function kill() public {
  if (msg.sender == owner) selfdestruct(owner);
  }
}

contract LuckyNumber is Mortal {
  uint minBet;
  uint houseEdge; // in %

  //true+amount or false+0
  event Won(bool _status, uint _amount);

  constructor(uint _minBet, uint _houseEdge) payable public {
    require(_minBet > 0);
    require(_houseEdge <= 100);
    minBet = _minBet;
    houseEdge = _houseEdge;
  }

  // Fallback function
  function() external {
    revert();
  }

  // Bet function
  function bet(uint _number) payable public {
    require(_number > 0 && _number <= 10);
    require(msg.value >= minBet);
    uint winningNumber = block.number % 10 + 1;
    if (_number == winningNumber) {
      uint amountWon = msg.value * (100 - houseEdge)/10;
      if(!msg.sender.send(amountWon)) revert();
      emit Won(true, amountWon);
    } else {
      emit Won(false, 0);
    }
  }

  // Owner can check balance of contract
  function checkContractBalance() Owned public view returns (uint) {
    return address(this).balance;
  }
 }
