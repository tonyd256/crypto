pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "../contracts/SimpleFund.sol";

contract TestSimpleFund {
  uint public initialBalance = 1 ether;

  function testFundCreation() public {
    uint goal = 100;
    SimpleFund fund = new SimpleFund(goal);
    Assert.equal(fund.owner(), address(this), "Fund owner should be creator.");
    Assert.equal(fund.goalAmount(), goal, "Fund goal should be set to input of constructor");
  }

  function testSendFunds() public {
    SimpleFund fund = new SimpleFund(100);
    Assert.equal(address(fund).balance, 0, "Fund should be empty.");
    fund.addFunds.value(1)();
    Assert.equal(address(fund).balance, 1, "Fund should have 1 wei.");
  }

  function testFullyFunded() public {
    SimpleFund fund = new SimpleFund(100);
    uint balance = address(this).balance;
    Assert.equal(address(fund).balance, 0, "Fund should be empty.");
    fund.addFunds.value(100)();
    Assert.equal(address(this).balance, balance, "Fund has transfered all money back to the owner.");
    Assert.equal(address(fund).balance, 0, "Fund should be empty.");
  }

  function testKill() public {
    SimpleFund fund = new SimpleFund(100);
    uint balance = address(this).balance;
    fund.addFunds.value(50)();
    Assert.equal(address(fund).balance, 50, "Fund should have some value.");
    fund.kill();
    Assert.equal(address(this).balance, balance, "Fund has transfered all money back to the owner.");
    Assert.equal(address(fund).balance, 0, "Fund should be empty.");
  }
}
