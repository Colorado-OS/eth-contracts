# Colorado OS - Parks Pass Registry Contracts

#### Initialize the parks pass with Grasshopper 

🍃 1) Applicant initializes parks pass application by sending a transaction to parks pass minter address.  Optional fee/donation can be included for CO parks regen deFi fund. 

🚀 2) Pass Minter collects metadata, updates ParksPassRegistry.sol contract with signed message, "Yes, we believe this DID points to a valid person|family|group|auto"  

💪🏽 3) Applicant signs message to solidify the parks pass by triggering contract call to mint and send a digital parks pass NFT to the applicant. 

#### Use Parks Pass 

1) Park goer signs message from address that holds valid digital parks NFT & creates a proof using Grasshopper. Signed message/proof can be stored in Ceramic with IDX and/or broadcast zk directly to the parks registry.   

2) Park will verify that the NFT is valid license holder when a proof is submitted by the park visitor. 

[Link to deployment script](../scripts/eth-denver-poc.py)
[Link to ParksPassRegistry.sol](../contracts/PARKS-PASS-REGISTRY.sol)