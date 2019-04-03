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


// Imports

// Contract variables


// Events


// Modifiers


// External functions


// Internal functions
