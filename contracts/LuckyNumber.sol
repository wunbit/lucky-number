// Solidity version
pragma solidity ^0.5.7;

// Contracts
contract Owned {
  address payable owner;

  constructor() public {
    // Sets the owner of Contract
    owner = msg.sender;
  }
}

contract Mortal is Owned {
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
}


// Imports

// Contract variables


// Events


// Modifiers


// External functions


// Internal functions
