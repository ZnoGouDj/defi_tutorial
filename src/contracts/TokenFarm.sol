pragma solidity ^0.8.12;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    address payable[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;


    constructor(DappToken _dappToken, DaiToken _daiToken) {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    function stakeTokens(uint _amount) public {

      //Transfer Mock Dai tokens to this contract for staking
      daiToken.transferFrom(msg.sender, address(this), _amount);

      //Update staking balance
      stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

      // Add user to stakers array *only* if they haven't staked already
      if (!hasStaked[msg.sender]) {
        stakers.push(payable(msg.sender));
      }

      // Update staking status
      isStaking[msg.sender] = true;
      hasStaked[msg.sender] = true;
    }
}

