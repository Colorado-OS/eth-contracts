// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity >=0.6.0;


/** 
 * @title - POC for Business License Regsitry 
 * @author - Zachary Wolff - @WolfDefi @gitcoin
 * @notice - ETHDenver 2021 ColoradoJam
 **/

/**
* @notice interface for interacting with BusinessLicenseToken contract 
*/
interface BusinessLicenseToken {
    function mint(address, string calldata) external;
}

contract BusinessLicenseRegistry {

/// @notice EIP-20 token name for this token
string public constant name = "BusinessLicenseRegistry";

/// @notice A record of state for applicant licesnse 
struct Status{
        bool state;
        bool applicant;
        uint256 expiry;
   }

/// @notice A map of addresses to license status
mapping(address => Status) public license;

/// @notice The EIP-712 typehash for the contract's domain
bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,address verifyingContract)");

/// @notice The EIP-712 typehash for the delegation struct used by the contract
bytes32 public constant STATE_LICENSING_TYPEHASH = keccak256("BusinessLicenseState(address licensee,uint256 expiry)");

/// @notice The EIP-712 typehash for the delegation struct used by the contract
bytes32 public constant APPLICANT_LICENSING_TYPEHASH = keccak256("BusinessLicensePlayer(address licensee)");

/// @notice Address that will be signing the original license application 
address public stateSigner;

/// @notice Address for the gamingTokenLicense contract 
address public businessToken; 

/// TODO: add more events & subGraphs 
/// @notice Business License Application Signature Validated Successfully 
event Application(address signatory, bool approved);

/**
   * @param _signer - public key matching the private key that wil be signing original application sig 
   * @param _businessToken - contract that will issue business license NFTs 
   **/
constructor(address _signer, address _businessToken) public {
    stateSigner = _signer;
    businessToken = _businessToken;
} 

/**
    * @notice Accepts signed business license application 
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
    require(signatory == stateSigner, "BLR::licenseFromState: invalid signature");
    require(now <= expiry, "BLR::delegateBySig: signature expired");
    // update mapping/state to show licensee has been approved by the state 
    return _setStateLicense(licensee, true, expiry);
}

/**
    * @notice Accepts signed business license application 
    * @param licensee The address to issue license to
    * @param v The recovery byte of the signature
    * @param r Half of the ECDSA signature pair
    * @param s Half of the ECDSA signature pair
    */
function licenseFromPlayer(address licensee, uint8 v, bytes32 r, bytes32 s) public {
    bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), address(this)));
    bytes32 structHash = keccak256(abi.encode(APPLICANT_LICENSING_TYPEHASH, licensee));
    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory == licensee, "BLR::licenseFromPlayer: invalid signature");
    require(getStateLicense(licensee), "BLR::licenseFromPlayer: State has not approved this address"); 
    _setApplicantLicense(licensee, true);
    _mintBusinessLicense(licensee, "https://colorado-os/business/<id>/");
}

/**
* @notice execute call gaming token license contract to issue NFT  
*/
function _mintBusinessLicense(address _licensee, string memory _tokenURI) private {
        BusinessLicenseToken BT = BusinessLicenseToken(businessToken);
        BT.mint(_licensee, _tokenURI);
} 

/// @notice get state status of license for a given address 
function getStateLicense(address licensee) public view returns(bool){
        return license[licensee].state;
}

/// @notice get applicant status of license for a given address 
function getApplicantLicense(address licensee) public view returns(bool){
        return license[licensee].applicant;
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

/// @notice set applicant license status for a given address 
function _setApplicantLicense(address licensee, bool _applicant) private {
        license[licensee].applicant = _applicant;
}


}
