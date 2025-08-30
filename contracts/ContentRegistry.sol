// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ContentRegistry (Conceptual Sketch)
 * @notice Illustrative interface only (not audited / not deployed).
 * Stores minimal anchors (hashes/roots) and emits events.
 */
contract ContentRegistry {
    event ContentRegistered(
        bytes32 indexed contentHash,     // leaf hash (SHA-256 represented as bytes32)
        string authorDID,                // e.g., did:key:... (pseudonymous)
        bytes32 merkleRoot,              // batch root
        string metadataCID,              // e.g., ipfs://CID
        uint256 blockTime               // block timestamp
    );

    mapping(bytes32 => bool) public seenLeaf;  // naive duplicate guard (illustrative)

    function registerContent(
        bytes32 contentHash,
        string calldata authorDID,
        bytes32 merkleRoot,
        string calldata metadataCID
    ) external {
        require(!seenLeaf[contentHash], "Duplicate leaf");
        seenLeaf[contentHash] = true;
        emit ContentRegistered(contentHash, authorDID, merkleRoot, metadataCID, block.timestamp);
    }
}
