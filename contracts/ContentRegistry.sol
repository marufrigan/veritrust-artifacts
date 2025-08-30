// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title VeriTrust Content Registry
 * @notice Minimal smart contract for anchoring content hashes on-chain.
 * @dev Compiles in Solidity 0.8.x. For demonstration/reproducibility only.
 */
contract ContentRegistry {
    // ------------------------
    // Events
    // ------------------------
    event ContentRegistered(
        bytes32 indexed contentHash,     // SHA-256 of the content
        string author,                   // Author name or DID
        string uri,                      // Optional URI (e.g., IPFS CID)
        uint256 timestamp,               // Block time of registration
        address indexed registrar        // Ethereum address that registered
    );

    // ------------------------
    // State
    // ------------------------
    struct Record {
        bytes32 contentHash;
        string author;
        string uri;
        uint256 timestamp;
        address registrar;
    }

    mapping(bytes32 => Record) private records;
    mapping(bytes32 => bool) public registered;
    uint256 public totalRecords;

    // ------------------------
    // Register new content
    // ------------------------
    function registerContent(
        bytes32 contentHash,
        string calldata author,
        string calldata uri
    ) external {
        require(!registered[contentHash], "Already registered");

        records[contentHash] = Record({
            contentHash: contentHash,
            author: author,
            uri: uri,
            timestamp: block.timestamp,
            registrar: msg.sender
        });

        registered[contentHash] = true;
        totalRecords++;

        emit ContentRegistered(
            contentHash,
            author,
            uri,
            block.timestamp,
            msg.sender
        );
    }

    // ------------------------
    // Get record details
    // ------------------------
    function getRecord(bytes32 contentHash) 
        external 
        view 
        returns (Record memory) 
    {
        require(registered[contentHash], "Not found");
        return records[contentHash];
    }
}
