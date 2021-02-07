// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.6.0;

/** 
 * @title - CoinFlip.sol - ETHDenver 2021 POC   
 * @author - Zachary Wolff - @WolfDeFi  
 * @notice - non-profit Web3 game of chance feeds $$-> Public Goods Pool  
 **/

// TODO add safemath.sol 

/**
* @notice interface for interacting with GamingLicenseToken contract 
*/
interface GamingLicenseToken {
    function balanceOf(address) external returns (uint256);
    
}

contract CoinFlip{ 

/// @notice Address for the gamingTokenLicense contract 
address public gamingTokenContract; 

/// @notice Max Bet Size in WEI
uint256 public maxBet; 

/// @notice map gaming license to balance
mapping(address => uint) public game_balances;

/// @dev debug events  
event BalanceOf(uint256 balanceOfNFTs); // debug 
event OddOrEven(string even); // debug 
event NotRandomNumber(uint notRandomNumber); //debug
event Winner(string congratulations);

/** 
* @param _gamingTokenContract - Gaming License Token Contract Address 
* @param _maxBet - Max Bet Size  
**/
constructor(address _gamingTokenContract, uint256 _maxBet) public {
    gamingTokenContract = _gamingTokenContract;
    maxBet = _maxBet;
} 


function placeBet() public payable {
    // Reject bets from accounts that don't hold a valid gaming license 
    require(isLicensed(msg.sender) == true, "CF :: A valid gaming license is required");
    
    // Reject bets that are too large 
    require(msg.value <= maxBet, "CF :: Bet size exceeds max");

    // Reject empty bets 
    require(msg.value > 0, "CF :: Wager is required to play");
    
    // reject losing bet
    require(_isWinner() == true, "CF :: Sorry! you lost");
    
    // reward winner 
    emit Winner("Nice bet! You won.");
    
} 

/**
* @notice check if msg.sender has a valid license token 
* @param _player address 
*/
function isLicensed(address _player) private returns (bool) {
    if (_getBalanceOf(_player) > 0) {
        return true;
    }
}

function _isWinner() internal returns (bool) {
    uint bad_random = _thisIsNotRandom();
    uint value = bad_random / 2;
    if (2 * value == bad_random) {
        // Update user balance
        uint256 payout = _calculatePayout();
        uint256 current_balance = game_balances[msg.sender];
        game_balances[msg.sender] = payout + current_balance;
        return true; // even wins
    } else {
        return false; // odd lose  
    }
}
// Coming soon - placholder for now 
function _calculatePayout() internal returns (uint256) {
    // TODO - remove house edge of x% and return bet minus house edge 
    return msg.value;
}

/**
* @notice get balanceOf from gaming license token contract for a given address 
* @param _player address 
* @return number of tokens provided address has
* @dev this needs to be strenghtened - 1) check token registry for token expiration  
*/
function _getBalanceOf(address _player) private returns (uint256){  
    GamingLicenseToken GT = GamingLicenseToken(gamingTokenContract);
    uint256 balance = GT.balanceOf(_player);
    // emit BalanceOf(balance);
    return balance;
         
} 

/**
* @notice this is not random - used for POC purposes, not safe for production! 
* @dev https://medium.com/better-programming/how-to-generate-truly-random-numbers-in-solidity-and-blockchain-9ced6472dbdf
*/
function _thisIsNotRandom() private returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty, now)));
}



}