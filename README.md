# Decentralized Donation App

## Overview  
This project is a decentralized donation app built on the Ethereum Sepolia Testnet. The app allows users to donate ETH to various campaigns, ensuring transparency, security, and a minimum USD donation. It uses Chainlink oracles to convert ETH to USD for enforcing donation limits.

## Contract Addresses  
- **Donation.sol:** `0xc3c01564ef25e292c203c1d5a2dffef92a421328`
- **PriceConverter.sol:** `0x14d4804156e996d9a3020e8895113c26a838e195` 

---

## Challenges and Solutions  

### 1. **Understanding Chainlink Oracles**  
Integrating Chainlink to get ETH/USD prices was new to me.  
**Solution:** I learned how to use Chainlink’s AggregatorV3Interface and tested fetching prices in Remix before integrating it into the contract.

### 2. **MetaMask and Remix Setup**  
Setting up Remix and connecting MetaMask to the Sepolia Testnet took a bit of time.  
**Solution:** I made sure to fund my MetaMask wallet with Sepolia ETH using a faucet and cleaned up the Remix workspace for easier development.

### 3. **Enforcing Minimum USD Donation**  
The challenge was converting ETH to USD and ensuring donations meet a minimum value.  
**Solution:** I used the `PriceConverter` library to fetch the ETH/USD price and set the minimum donation to $50.

### 4. **Reentrancy Attack Prevention**  
Securing the `withdraw()` function was a priority.  
**Solution:** I followed best practices to prevent reentrancy attacks, using the Checks-Effects-Interactions pattern and added a `ReentrancyGuard` to the contract.

---

## Key Features  

- **Secure Donations:** Donations are only accepted if they meet the minimum USD value.
- **Owner Withdrawals:** Only the contract owner can withdraw funds.
- **Price Conversion:** Converts ETH to USD using Chainlink oracles.
- **Fallback Donations:** Handles direct ETH transfers using the `receive()` function.

---

## Deployment and Testing  

1. **Set Up Remix:**  
   Clean the workspace and create `Donation.sol` and `PriceConverter.sol`.

2. **MetaMask Setup:**  
   Switch to the Sepolia Testnet and fund your wallet with Sepolia ETH using a faucet.

3. **Deploy the Contract:**  
   Deploy `Donation.sol` with the Chainlink ETH/USD price feed address: `0x694AA1769357215DE4FAC081bf1f309aDC325306`.

4. **Test the Contract:**  
   - Use the `fund()` function to make donations and confirm the `DonationReceived` event is triggered.  
   - Test withdrawals to ensure only the owner can withdraw funds.

---

## Conclusion  
This project taught me the importance of security, price oracles, and using best practices when developing smart contracts. Even though I faced challenges with testing and ensuring all features worked as expected, I successfully built a functional decentralized donation app. This project has been an excellent learning experience, and I’m excited to keep building more Web3 applications.
