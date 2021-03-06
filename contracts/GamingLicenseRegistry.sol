// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity >=0.6.0;


/** 
 * @title - POC for Gaming License Regsitry 
 * @author - Zachary Wolff - @WolfDefi
 * @notice - ETHDenver 2021 ColoradoJam
 **/

/**
* @notice interface for interacting with GamingLicenseToken contract 
*/
interface GamingLicenseToken {
    function mint(address, string calldata) external;
}

contract GamingLicenseRegistry {

/// @notice EIP-20 token name for this token
string public constant name = "GamingLicenseRegistry";

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

/// @notice The EIP-712 typehash for the delegation struct used by the contract
bytes32 public constant STATE_LICENSING_TYPEHASH = keccak256("GamingLicenseState(address licensee,uint256 expiry)");

/// @notice The EIP-712 typehash for the delegation struct used by the contract
bytes32 public constant PLAYER_LICENSING_TYPEHASH = keccak256("GamingLicensePlayer(address licensee)");

/// @notice Address that will be signing the original license application 
address public stateSigner;

/// @notice Address for the gamingTokenLicense contract 
address public gamingToken; 

/// TODO: add more events & subGraphs 
/// @notice Gaming License Application Signature Validated Successfully 
event Application(address signatory, bool approved);

/**
   * @param _signer - public key matching the private key that wil be signing original application sig 
   * @param _gamingToken - contract that will issue gaming license NFTs 
   **/
constructor(address _signer, address _gamingToken) public {
    stateSigner = _signer;
    gamingToken = _gamingToken;
} 

/**
    * @notice Accepts signed gaming license application 
    * @param licensee The address to issue license to
    * @param expiry The time at which to expire the signature
    * @param v The recovery byte of the signature
    * @param r Half of the ECDSA signature pair
    * @param s Half of the ECDSA signature pair
    */
function licenseFromState(address licensee, uint expiry, uint8 v, bytes32 r, bytes32 s) public {
    bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), address(this)));
    bytes32 structHash = keccak256(abi.encode(STATE_LICENSING_TYPEHASH, licensee, expiry));
    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory == stateSigner, "GLR::licenseFromState: invalid signature");
    require(now <= expiry, "GLR::delegateBySig: signature expired");
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
function licenseFromPlayer(address licensee, uint8 v, bytes32 r, bytes32 s) public {
    bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), address(this)));
    bytes32 structHash = keccak256(abi.encode(PLAYER_LICENSING_TYPEHASH, licensee));
    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory == licensee, "GLR::licenseFromPlayer: invalid signature");
    require(getStateLicense(licensee), "GLR::licenseFromPlayer: State has not approved this address"); 
    _setPlayerLicense(licensee, true);
    _mintGamingLicense(licensee, "gaming/v/1"); 
}

/**
* @notice execute call gaming token license contract to issue NFT  
*/
function _mintGamingLicense(address _licensee, string memory _tokenURI) private {
        GamingLicenseToken GT = GamingLicenseToken(gamingToken);
        GT.mint(_licensee, _tokenURI);
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


}
