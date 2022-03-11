pragma solidity ^0.8.7;

import 'Interface/IERC20.sol';
contract StakingReward {
    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    uint public rewardRate = 100;
    uint public lastUpdateTime;
    uint public rewardPerTokenStored;

    mapping(address => uint) public userRewardperTokenPaid;
    mapping(address => uint) public rewards;

    uint private _totalSupply;
    mapping(address => uint) private _balances;

    constructor(address _stakingToken,address _rewardToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardToken);
    }

    function rewardPerToken() public view returns (uint) {

    }

    function earned(address account) public view returns (uint){

    }

    modifier updateReward(address account) {

        _;
    }

    function stake(uint _amount) external updateReward(msg.sender) {

    }

    function getReward() external updateReward(msg.sender) {

    }

}