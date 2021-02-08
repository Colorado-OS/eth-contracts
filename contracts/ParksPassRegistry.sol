// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity >=0.6.0;


/** 
 * @title - POC for Gaming License Regsitry 
 * @author - Zachary Wolff - @WolfDefi
 * @notice - ETHDenver 2021 ColoradoJam
 **/

/**
* @notice interface for interacting with ParksPassToken contract that issues NFT 
*/
interface ParksPassToken {
    function mint(address, string calldata) external;
}

interface CEth {
    function mint() external payable;
    function redeemUnderlying(uint redeemAmount) external returns (uint);
}    

contract ParksPassRegistry {

/// @notice EIP-20 token name for this token
string public constant name = "ParksPassRegistry";

/// @notice A record of state for applicant licesnse 
struct Status{
        bool state;
        bool player;
        uint256 expiry;
   }

/// @notice A map of addresses to license status
mapping(address => Status) public license;

/// @notice The EIP-712 typehash for the contract's domain
bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,address verifyingContract)");

/// @notice The EIP-712 typehash for the license minter struct used by the contract
bytes32 public constant STATE_PASS_TYPEHASH = keccak256("ParksPassState(address licensee,uint256 expiry)");

/// @notice The EIP-712 typehash for the delegation struct used by the contract
bytes32 public constant USER_PASS_TYPEHASH = keccak256("ParksPassUser(address licensee)");

/// @notice Address that will be signing the original license application 
address public stateSigner;

/// @notice Address for the ParksPassToken contract 
address public parksPassToken; 

/// @notice admin address used to manage defi positions 
address public multiSig;

address payable cETHContract;

// used restrict activities to a single address 
modifier onlyMultiSig {
    require(msg.sender == multiSig, "ParksPassRegistry :: insuffiecent permissions");
    _;
}

/// TODO: add more events & subGraphs 
/// @notice Parks Pass Application Signature Validated Successfully 
event Application(address signatory, bool approved);

/**
   * @param _signer - public key matching the private key that wil be signing original application sig 
   * @param _parksPassToken - contract that will issue gaming license NFTs 
   **/
constructor(address _signer, address _parksPassToken, address payable _cETHContract, address _multiSig) public {
    stateSigner = _signer;
    parksPassToken = _parksPassToken;
    cETHContract = _cETHContract;
    multiSig = _multiSig;
} 

/**
    * @notice Accepts signed gaming license application 
    * @param licensee The address to issue license to
    * @param expiry The time at which to expire the signature
    * @param v The recovery byte of the signature
    * @param r Half of the ECDSA signature pair
    * @param s Half of the ECDSA signature pair
    */
function parksPassFromState(address licensee, uint expiry, uint8 v, bytes32 r, bytes32 s) public {
    bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), address(this)));
    bytes32 structHash = keccak256(abi.encode(STATE_PASS_TYPEHASH, licensee, expiry));
    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory == stateSigner, "ParksPassRegistry::parksPassFromState: invalid signature");
    require(now <= expiry, "ParksPassRegistry::parksPassFromState: signature expired");
    // update mapping/state to show licensee has been approved by the state 
    return _setStateLicense(licensee, true, expiry);
}

/**
    * @notice Accepts signed gaming license application 
    * @param licensee The address to issue license to
    * @param v The recovery byte of the signature
    * @param r Half of the ECDSA signature pair
    * @param s Half of the ECDSA signature pair
    */
function parksPassFromPlayer(address licensee, uint8 v, bytes32 r, bytes32 s) public payable {
    bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), address(this)));
    bytes32 structHash = keccak256(abi.encode(USER_PASS_TYPEHASH, licensee));
    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory == licensee, "ParksPassRegistry::parksPassFromPlayer: invalid signature");
    require(getStateLicense(licensee), "ParksPassRegistry::parksPassFromPlayer: State has not approved this address"); 
    _setPlayerLicense(licensee, true);
    _mintGamingLicense(licensee, "https://colorado-OS/gaming/asdfasdf");
    require(supplyEthToCompound() == true, "ParksPassRegistry::parksPassFromPlayer: failed to open defi position on Compound");
}

/**
* @notice execute call gaming token license contract to issue NFT  
*/
function _mintGamingLicense(address _licensee, string memory _tokenURI) private {
        ParksPassToken PPT = ParksPassToken(parksPassToken);
        PPT.mint(_licensee, _tokenURI);
} 

/// @notice get state status of license for a given address 
function getStateLicense(address licensee) public view returns(bool){
        return license[licensee].state;
}

/// @notice get player status of license for a given address 
function getPlayerLicense(address licensee) public view returns(bool){
        return license[licensee].player;
}

/// @notice get expriation in unix time for a given license address
function getLicenseExpiry(address licensee) public view returns(uint256){
        return license[licensee].expiry; 
}

/// @notice set state license status for a given address
function _setStateLicense(address licensee, bool _state, uint256 _expiry) private {
        license[licensee].state = _state;
        license[licensee].expiry = _expiry; 
}

/// @notice set player license status for a given address 
function _setPlayerLicense(address licensee, bool _player) private {
        license[licensee].player = _player;
}

/// @notice opens deFi position with a portion of parks pass fee on pass creation 
function supplyEthToCompound() public payable returns (bool){
            CEth(cETHContract).mint.value(msg.value).gas(250000)();
            return true;
}     

/// @notice multisig can redeem cETH from Compound returns 0 if successful 
function redeemcEthFromCompound(uint amount_in_wei) public onlyMultiSig returns (uint){
            CEth CE = CEth(cETHContract);
            uint success = CE.redeemUnderlying(amount_in_wei);
            return success; 
}     

/// @notice multiSign can WD ETH 
function withdrawAmount(uint256 amount) public onlyMultiSig {
         require(amount <= getEthBalance());
         msg.sender.transfer(amount);
   
}

/// @notice  What is the Ethereum Balance of the contract 
function getEthBalance() public view returns (uint) {
    address(this).balance;
}


}
