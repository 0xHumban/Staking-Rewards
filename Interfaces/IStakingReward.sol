pragma solidity ^0.8.7;

interface IStakingReward {
    function stake(uint256 _amount) external;

    function exit() external;

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

}