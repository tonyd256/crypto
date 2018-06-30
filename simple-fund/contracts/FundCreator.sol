pragma solidity ^0.4.24;

import './SimpleFund.sol';

contract FundCreator {
  event FundCreated(address owner);

  function createFund(uint goal) public returns(SimpleFund fundAddress) {
    SimpleFund fund = new SimpleFund(goal);
    emit FundCreated(msg.sender);
    return fund;
  }
}
