pragma solidity ^0.8.7;

import 'Interfaces/IERC20.sol';
import 'Interfaces/IStakingReward.sol';
contract StakingReward {
    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    uint256 public rewardRate = 100;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    constructor(address _stakingToken,address _rewardToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardToken);
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }


    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return 0;
        }
        return rewardPerTokenStored + (
            rewardRate * (block.timestamp - lastUpdateTime) * 1e18 / _totalSupply
            );
    }

    function earned(address account) public view returns (uint256){
        return (
            _balances[account] * rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18;
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        rewards[account] = earned(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }

    function stake(uint256 _amount) external updateReward(msg.sender) {
        _totalSupply += _amount;
        _balances[msg.sender] += _amount;
        stakingToken.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint256 _amount) public updateReward(msg.sender) {
        _totalSupply -= _amount;
        _balances[msg.sender] -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

    function exit() external {
        withdraw(_balances[msg.sender]);
        getReward();
    }

    function getReward() public updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        rewardsToken.transfer(msg.sender, reward);
    }

}