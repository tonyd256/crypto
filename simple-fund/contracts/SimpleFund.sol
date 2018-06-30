pragma solidity ^0.4.24;

contract SimpleFund {
  address public owner;
  uint public goalAmount;

  event FundsAdded(address sender, uint amount);
  event GoalReached();

  constructor(uint goal) public {
    owner = msg.sender;
    goalAmount = goal;
  }

  function addFunds() public payable {
    emit FundsAdded(msg.sender, msg.value);

    if (address(this).balance >= goalAmount) {
      emit GoalReached();
      selfdestruct(owner);
    }
  }

  function kill() public {
    require(msg.sender == owner);
    selfdestruct(owner);
  }
}
