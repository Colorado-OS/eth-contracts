# Colorado OS - ETHDenver 2021 - ColoradoJAM 

### What is Colorado OS? 
Colorado OS was built to demonstrate how Web3 could be used to establish a digital backbone for a more usable, efficient, and secure public network infrastructure. Initially we introduce [Grasshopper Digital Signature Interface](https://github.com/Colorado-OS/Grasshopper) as a means of connecting self sovereign IDs into Web3 and Colorado OS but Grasshopper is not required. 

### ETHDenver ColoradoJam 2021 
🦄 We envision Colorado OS starting as an series of decentralized license registries on Web3. We think there is room for more though. 

We think a system like this could reduce complexity, create new connections, and strengthen privacy & security elements of public infrastructure in Colorado.  

🌎 1) First, we show how a deFi state parks pass could be issued to a self-sovereign ID with Colorado OS. In the spirit of regen finance, we allocate an optional **portion of the parks pass fee to an interest bearing DeFi position. This position generates recurring APY revenue for Colorado Parks.** ⭐ 

🎲 2) Sticking with regen finance, we explore how Colorado OS can mint and issue a **digital gaming license** for players that can be used on Web3 **non-profit games of chance**. ⭐ 

### UseCase #1 - Web3 State Parks Pass w/Defi
First Colorado OS issues a Web3 digital parks pass to a self sovereign identity. The digital signature can be associated to a person, group, family, or something else, like an automobile. 

When a user visits the park, they can write the proof record to a Ceramic user store and/or issue a zkProof to the contract registry with information from their CO Parks Pass. 

[PARKS-PASS-README.md here](./docs/PARKS-PASS-README.md). 

### UseCase #2 - Not-for-profit games of chance $$$ --> Public Infrastructure
First Colorado OS issues a Web3 digital gaming license NFT to the player that unlocks a trusted set of Web3 based games. Next, all gaming profits are pooled into a public goods and infrastructure contract. This could help establish a foundation for something like quadratic funds distribution through self sovereign IDs.  

You can find the contracts and deployment scripts here on the GamingLicense & Token Contract  [GAMING README here](./docs/GAMING-LICENSE.md). 

### How Colorado OS works 
🦗 Initially, self-sovereign IDs are connected to Colorado OS using [Grasshopper Digital Signature Exchange](https://github.com/Colorado-OS/Grasshopper). Grasshopper is minimalist way to mint digital attestations or cryptographic proofs about an arrangement or exchange. 

Once you've connected a wallet/account into Colorado OS (using Grasshopper or an existing Web3 tool/util) you can begin to interact with other on-chain components of Colorado OS.

**Standard Ethereum wallets and Web3 DID solutions can be used with Grasshopper & Colorado OS :)**  

💡 Grasshopper has been bootstrapped from these awesome [Compound.Finance governance examples](https://github.com/compound-developers/compound-governance-examples) using EIP712 signed messages for voting and delegation.💡 

### Beyond ETHDenver
Colorado OS license registries could be deployed for business, professional, fishing & hunting, and other types of licenses.  Grasshopper aims to be the crypto glue that connects Web3 & self-sovereign ids. It is experimental and not well tested. 

**We can also see this working nicely as an entry way to secure Web3 tax systems and a public/private GPS network.**

Zero Knowledge Proofs & layer 2 connections are on the road map. 

### Other Possible Use Cases For Colorado OS 
### Web3 Business Registry (**Larkin's Idea**)
Here we show how Grasshopper and Colorado OS can check ID & deploy a business registry contract to Ethereum that mints and distributes a Signed Digital Business License NFT. 

### Web3 Outdoor (Hunting & Fishing) Licensing (TODO)

### Web3 Professional Licensing (TODO) 

### Web3 State Tax System 

### Web3 public GPS network

### ???

### Disclaimer 
This is a proof of concept and is not ready for mainnet. There are security and privacy challenges that have not yet been reviewed and addressed. Both Colorado OS and Grasshopper should be audited by cryptographers. 

The CoinFlip game has been left without a coin withdraw function intentionally. Other features have been left out as well to keep it simple. We _could_ use ChainLink or an other oracle to generate a seed of entropy and fork the CoinFlip contract to seed provably fair tournament trees. We think there  a host of other possibilities in this area as well that go beyond public    
