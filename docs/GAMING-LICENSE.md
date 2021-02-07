## Colorado OS - Gaming License Registry, Token, & CoinFlip Contracts

#### Digital Gaming Passport    
In this example Grasshopper is used to issue a digital gaming license token (EIP721 NFT). This token enables licensed players to interact with a defined set of non-profit web3 games. 

You can find more information about how the contracts are deployed & work together on-chain by checking out the [eth-denver-poc.py brownie deployment script](../scripts/eth-denver-poc.py).

Please see [gaming license registry](../contracts/GamingLicenseRegistry.sol) and [gaming token contracts](../contracts/GamingLicenseToken.sol) for more information about the how the contracts themselves.  

#### Game - CoinFlip.sol
For ETHDenver 2021 POC we created a simple Coinflip.sol contract on Etheruem Rinkeby network. The game will only accept bets from players that hold a valid Digital Gaming License. A simple coin flip mechanism will resolve and settle the bet. All profits from the game can be pulled into the public goods contract pool. You can find details on the [CoinFlip.sol game here.](../docs/COINFLIP.md)

---
[TODO]
##### Public Goods & Infrastructure Pool 
This contract acts as a collection interface to receive and store gaming profits and funds. It is designed to be managed by a multisig wallet so that approval tiers can be configured to match a variety of scenarios. For example, it could be configured to require signatures from multiple groups or individuals to pull and disperse the funds into public infrastructure project

The first contract manages a license registry. This is essentially a mapping of  and the second is dedicated to issuing the EIP721 NFT Gaming Token Licenses.  

