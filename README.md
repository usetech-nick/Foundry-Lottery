# 🎟️ Raffle Smart Contract (Foundry)

A **provably fair raffle (lottery) smart contract** built with **Foundry** and deployed live on **Sepolia**, using **Chainlink VRF** for secure randomness.

This project was built end-to-end: design → testing → deployment → live execution.

---

## ✨ Features

- 🎫 Permissionless raffle entry
- 🔒 Secure randomness via Chainlink VRF
- 🧪 Comprehensive testing with Foundry
- 🚀 Live deployment on Sepolia
- ✅ Verified contract on Etherscan

---

## 🔗 Live Deployment

- **Network:** Sepolia  
- **Contract:** https://sepolia.etherscan.io/address/0xBD2D768B8b332151c6b58BfE0E065ae5118a7749
- All interactions (entry, VRF fulfillment, winner selection) are **public and verifiable on-chain**.

---

## 🧠 How It Works

1. Users enter the raffle by paying the entrance fee  
2. After the interval passes, a winner is requested via Chainlink VRF  
3. VRF provides verifiable randomness  
4. A winner is selected and paid automatically  

No admin intervention. No trusted party.

---

## 🧪 Testing

### ⚙️ Project Setup (Makefile)

This project uses a `Makefile` to simplify common Foundry workflows.

#### Build contracts
```bash
make build

Run tests

make test

Install dependencies

make install
```
This installs:

- forge-std
- chainlink-brownie-contracts
- solmate
- foundry-devops

Deploy to Sepolia

    make deploy-sepolia

This command:

1. Uses the Sepolia RPC from .env
2. Deploys using a Foundry keystore account
3. Broadcasts transactions
4. Verifies the contract on Etherscan

- Environment variables are loaded automatically from .env.


---

## 🚀 Deployment

Deployment is handled via Foundry scripts.
```
forge script script/DeployRaffle.s.sol \
  --rpc-url <RPC_URL> \
  --account <ACCOUNT_NAME> \
  --broadcast \
  --verify
```

Secrets are managed via .env (not committed).

🛠 Tech Stack

- Solidity
- Foundry
- Chainlink VRF
- Sepolia Testnet

## 📌 Notes

This project was built to deeply understand:

1. Smart contract testing workflows
2. Chainlink VRF integration
3. Deployment & verification pipelines
4. Real-world EVM behavior

#### 📜 License: MIT
---

