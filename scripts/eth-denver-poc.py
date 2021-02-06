
from brownie import accounts, web3, Wei, GamingLicenseToken, GamingLicenseRegistry, CoinFlip

import sys 
# *** basic usage 
# brownie run eth-denver-poc.py --gas  
# or from run the console first ($ brownie console), then run: run('eth-denver-poc')
# for individual functions (after initial deploy) - run('eth-denver-poc', 'placeWager') 

maxBetEth = .1
stateSigningAddress = '0xA1df472Fc3d9f9E5F54137D2878A3fA8adB63351' 

def main():
    '''Deploy the base contracts, GamingLicenseToken.sol, GamingLicenseRegistry.sol, CoinFlip.sol'''
    # print out some relevant info about our testing env 
    loginfo()

    # 1) deploy the Gaming License Token contract 
    try:
        # <ContractConstructor 'GamingLicenseToken.constructor(string name, string symbol, string baseURI)'> 
        glt = GamingLicenseToken.deploy("Gaming License Registry", "GLR", "http://something.com/", {'from': accounts[0]})
        # print(f'Gaming License Token address {glt.address}')
    except:
        e = sys.exc_info()[0]
        print(f'Error on Gaming License Token contract deploy {e}' )
        sys.exit(1)
    
    # 2) deploy Gaming License Registry Contract
    try:
        # <ContractConstructor 'GamingLicenseRegistry.constructor(address _signer, address _gamingToken)'> 
        # glr = GamingLicenseRegistry.deploy('0xA1df472Fc3d9f9E5F54137D2878A3fA8adB63351', '0xA46A74e16fAED1527AB16d9ED3231Fc989843594', {'from': accounts[0]})
        glr = GamingLicenseRegistry.deploy(stateSigningAddress, glt.address, {'from': accounts[0]})
        # print(f'Gaming License Registry address {glr.address}')
    except:
        e = sys.exc_info()[0]
        print(f'Error on deploying Gaming License Registry contract deploy {e}' )
        sys.exit(1)

    # 3) deploy Coin Flip contract 
    try:
        # >>> CoinFlip.deploy
        # <ContractConstructor 'CoinFlip.constructor(address _gamingTokenContract, uint256 _maxBet)'>
        cf = CoinFlip.deploy(glt.address, Wei("1 ether"), {'from': accounts[0]})
    except:
        e = sys.exc_info()[0]
        print(f'Error on deploying Coin Flip contract deploy {e}' )
        sys.exit(1)
    
    base_setup_config(glr, glt, cf)


def base_setup_config(glr, glt, cf):
    '''run base config/setup transactions to set things up'''
    setMinter(glt, glr)

def loginfo():
    # accounts being used 

    print(f"\nWeb3 Provider URL: {web3.provider.endpoint_uri}\n")

    for account_number in range(9):
        print(f"account #: {account_number} - {accounts[account_number]}")
    
    print("\n")    
    

def setMinter(glt, glr):
    '''GamingLicenseToken needs the minter role set to the GamingLicenseRegistry contract so that it can mint licenses/tokens'''
    # >>> web3.keccak(text="MINTER_ROLE")
    # HexBytes('0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6')
    minter = '0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6'
    try:
        # >>> GamingLicenseToken[0].grantRole
        # <ContractTx 'grantRole(bytes32 role, address account)'>
        glt.grantRole(minter, glr.address, {'from': accounts[0]})
    except:
        e = sys.exc_info()[0]
        print(f'Error on setting minter role {e}' )
        sys.exit(1)

def placeWager():
    '''Place a wager against the coinflip game contract. Note - you must first manually obtain a license (via the UI) or your bet will be rejected'''
    cf = CoinFlip[0] # reference contract 
    try: 
        # place bet require no params but in order to successfully place a wager msg.sender must have gaming license NFT in wallet  
        # >>> CoinFlip[0].placeBet
        # <ContractTx payable 'placeBet()'>
        bet_result = cf.placeBet({'from': accounts[1], 'value': 100000000000000000})
        print(f'Bet Result: {bet_result.events}')
    except error as e:
        print(f'There was an error placing a bet: {e}')
    



  

    
    

    
