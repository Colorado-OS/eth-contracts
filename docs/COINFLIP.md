# CoinFlip.sol 
[CoinFlip Contract](../contracts/CoinFlip.sol) 


## What is CoinFlip?
CoinFlip is a very simply blockchain based game of chance that aims to model a couple new concepts for ETHDenver 2021 Colorado JAM. 

First, using the [Colorado-OS](https://github.com/Colorado-OS/eth-contracts) digital licensing system we show how the state could securely mint a Web3 digital players gaming license. This license can be used on select blockchain based games of chance. 

Second, we show how all profits from these decentralized games of chance could be automatically moved into a public goods pool (multisig for now). **Thus creating a licensed blockchain based non-for-profit game of chance**

## Game Mechanics 
This is a simple quick coin flip game contract built to demo Colorado OS & Grasshopper digital gaming license concepts. 

This POC contract should _NOT_ be used on mainnet. One reason for that is that we've used a sudo random generator. There are are other reasons too. Some of those reason are not related to the technology. 

CoinFlip.sol was developed as one piece of a larger poof of concept. Many details and features of a good game have been intentionally left out. Not-for-profit games of chance feeding public goods pools is a knotty concept. 

💎 We can see a fork of CoinFlip.sol that incorporates ChainLink provably fair random seed distributions. These seeds could be used for off-chain provably fair tournament trees on web2 💎    

## SETUP & DEPLOY 
Full setup is easy with Brownie check the [script here](../scripts/rinkeby-eth-denver-poc.py) 





