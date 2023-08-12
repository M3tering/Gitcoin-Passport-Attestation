// SPDX-License-Identifier: GPL
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IEAS.sol";

contract Scorer is Ownable {
    error NoPassport();

    uint256[][] public weights;
    IEAS public constant EAS = IEAS(0xAcfE09Fd03f7812F022FBf636700AdEA18Fd2A7A);
    IEAS public constant RESOLVER = IEAS(0xAcfE09Fd03f7812F022FBf636700AdEA18Fd2A7A); // TODO: use correct interface

    function setWeights(uint256[][] memory _weights) public onlyOwner {
        weights = _weights;
    }

    function getUUID(address account) public returns (bytes32) {
        bytes32 uuid = RESOLVER.getAttestationUUID(account);
        if (uuid == bytes32(0)) revert NoPassport();
        return uuid;
    }

    function decodeAttestation(bytes32 uuid) public {
        Attestation memory attestation = EAS.getAttestation(uuid);
    }
}
