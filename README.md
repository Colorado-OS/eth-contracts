# Colorado OS - ETHDenver 2021 - ColoradoJAM 

### Colorado OS - DeFi-Charged Backbone for Licensing
Colorado OS was built to demonstrate how Web3 could be used to establish a digital backbone for a more usable, efficient, and secure public infrastructure in Colorado. 

Demo site can be found here [colorado-os.github.io](https://colorado-os.github.io) and a more high level project write up can be found [here](./docs/TODO.pdf). 

---
### 🌈  ETHDenver ColoradoJam 2021  🌈
🦄 We envision Colorado OS starting as an series of decentralized license registries on Web3 but we believe a lot more could be done with a system like this.  

💚 We think Colorado OS would reduce complexity, create new connections, and strengthen privacy & security elements of public infrastructure in Colorado while simultaneously, in part, funding itself. 

🌎 1) First, we show how a deFi primed digital parks pass could be issued to a self-sovereign ID using Colorado OS. In the spirit of regen finance, we allocate an optional **portion of the pass fee to an interest bearing DeFi position. This fund generates recurring APY revenue for Colorado Parks.** ⭐ 

🎲 2) Sticking with regen finance, we explore how Colorado OS can mint & issue a **digital players gaming license NFT** that can be used to power **non-profit Web3 games of chance and fuel public goods funding in Colorado.** ⭐ 

---
### 🌎 UseCase #1 - Web3 State Parks Pass w/Defi charge
First Colorado OS issues a Web3 digital parks pass to a self sovereign identity. The digital parks pass can be associated with a person, group, family, or something else like an automobile. 

When a user visits the park, they can mint & write record of the proof to a self sovereign data store like [Ceramic & IDX](https://blog.ceramic.network/building-with-decentralized-identity-on-idx-and-ceramic/),* and/or issue a zkProof* to the contract registry with their CO digital parks pass.  

[More info can be found on the PARKS-PASS-README here](./docs/PARKS-PASS-README.md). 

---
### 🎲 UseCase #2 - non-profit game of chance feeds $$$ --> Colorado Public Goods 
First Colorado OS issues a Web3 digital gaming license NFT to the player. This license allows it's holder to access a Web3 [CoinFlip](./contracts/CoinFlip.sol) non-profit game of chance on Rinkeby. 

We demo a betting bot simulator that explores how long it might take to generate 10 Million dollars for Colorado Public Goods with the CoinFlip.sol game.

All gaming profits are pooled into a public goods and infrastructure contract. **This could help establish a foundation for quadratic funds distribution though self sovereign IDs.**  

You can find the contracts and deployment scripts for the GamingLicense & GamingToken contracts on the [GAMING README here](./docs/GAMING-LICENSE.md). 

---
### How Colorado OS works 
🦗 Initially, self-sovereign IDs are connected to Colorado OS using [Grasshopper Digital Signature Exchange](https://github.com/Colorado-OS/Grasshopper). Grasshopper is minimalist way to mint digital attestations or cryptographic proofs about an arrangement or exchange. 

Once an SSID is connected into Colorado OS you can begin to interact with other on-chain components of Colorado OS as well.

**Standard Ethereum wallets and Web3 DID solutions can be used with Grasshopper & Colorado OS :)**  

💡 Grasshopper has been bootstrapped from these awesome [Compound.Finance governance examples](https://github.com/compound-developers/compound-governance-examples) using EIP712 signed messages for voting and delegation.💡 

---
### Beyond ETHDenver
Colorado OS Web3 registries could be deployed in support of business, professional, fishing, hunting, and other licenses or passes.  Grasshopper aims to be the crypto glue that connects Web3 & self-sovereign ids but it's still in an early & highly experimental phase. Colorado OS can work without Grasshopper using another interface to Web3.  

**We can also see this working nicely as an entry way to secure Web3 tax systems and a public/private GPS network.**

Zero Knowledge Proofs & layer 2 connections are on the road map. 
___
### Other Possible Use Cases For Colorado OS 
### Web3 Business Registry (**L reynolds Idea**)
New FINCEN regulations require verification of IDs for new business creation. Here we show how Grasshopper and Colorado OS can be used to check ID & deploy a business registry contract to Ethereum that mints and distributes a signed digital business license NFT. 

**[Currently in development](./contracts/BusinessLicenseRegistry.sol)** 

### Web3 Outdoor Licensing
Hunting, fishing, other. 

### Web3 Professional Licensing

### Web3 State Tax System 

### Web3 public GPS network 
Decentralized satellite network feeds self sovereign GPS beacon maps.   

### ...???

---
### Disclaimer 
This is a proof of concept and not on mainnet. There are security and privacy challenges that have not yet been reviewed and addressed. Both Colorado OS and Grasshopper should be audited.  

The CoinFlip game has been left without a coin withdraw function intentionally. Other features have been left out as well to keep it simple. We _could_ use ChainLink or an other oracle to generate a seed of entropy and fork the CoinFlip contract to generate provably fair tournament trees. We believe there are other possibilities in this area as well that go beyond non-profit public games of chance and into the private gaming realm but they have not been addressed for this POC.      

*Didn't have time to get Ceramic added for ETHDEnver POC :( and will need some help integrating & implementing zero knowledge proofs into the registries and/or self sovereign data stores. 

---

 ❤️🧡💛💚💙💜  ETHDenver 2021 - ColoradoJam  ❤️🧡💛💚💙💜