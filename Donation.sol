// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./PriceConverter.sol";

contract Donation {
    using PriceConverter for uint256;

    address public owner;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    // Track donations by address
    mapping(address => uint256) public donations;
    address[] public funders;

    // Events to log donations and withdrawals
    event DonationReceived(address indexed donor, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can withdrawn funds.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Payable function to accept donations
    function fund() public payable {
        require(
            msg.value.getConversionRate() >= MINIMUM_USD, 
            "Minimum donation is $50"
        );
        donations[msg.sender] += msg.value;
        funders.push(msg.sender);
        emit DonationReceived(msg.sender, msg.value);
    }

    // Function to withdraw all funds
    function withdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");

        // Transfer all funds to owner
        (bool success, ) = owner.call{value: contractBalance}("");
        require(success, "Withdrawall failed.");

        emit FundsWithdrawn(owner, contractBalance);
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    receive() external payable {
        emit DonationReceived(msg.sender, msg.value);
    }

}