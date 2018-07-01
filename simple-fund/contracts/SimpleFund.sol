pragma solidity ^0.4.24;

contract SimpleFund {
  address public owner;
  uint public goalAmount;
  bool public goalReached;

  event FundsAdded(address sender, uint amount);
  event GoalReached();

  constructor(uint goal) public {
    owner = msg.sender;
    goalAmount = goal;
    goalReached = false;
  }

  function addFunds() public payable {
    require(!goalReached);
    emit FundsAdded(msg.sender, msg.value);

    if (address(this).balance >= goalAmount) {
      goalReached = true;
      emit GoalReached();
      selfdestruct(owner);
    }
  }

  function kill() public {
    require(msg.sender == owner);
    goalReached = true;
    selfdestruct(owner);
  }
}
