// SPDX-License-Identifier: MIT
/*
This line declares the license for the code. It's a best practice for open-source projects.
*/
pragma solidity ^0.8.20;

/*
================================================================================
|                              TrustLens Contract                              |
|   The decentralized, immutable ledger for the Trust Passport reputation system.  |
================================================================================
This contract acts as a public digital notary. Its sole purpose is to store
permanent, verifiable proofs ("Attestations") of positive user actions.

- It is SECURE: Only the owner (your backend) can add new records.
- It is TRANSPARENT: Anyone can read the records for free.
- It is EFFICIENT: It only stores the final proof, not large data like review text.
*/

contract TrustLens {

    // --- STATE VARIABLES ---

    // `owner` stores the address of the account that deploys this contract.
    // This will be your wallet, and you will give its private key to your backend server.
    // This is the heart of the security model.
    address public owner;

    // This `Attestation` struct defines the data structure for a single "proof of trust".
    // It's the template for each entry in our ledger.
    struct Attestation {
        string actionType;      // A simple label for the action, e.g., "positive_review".
        address attestedBy;     // The address of the platform that verified this (the owner).
        uint256 timestamp;      // The time the attestation was recorded on the blockchain.
    }

    // This `mapping` is the core data structure of our ledger.
    // It's a public dictionary that links a user's wallet address to a list of their Attestations.
    // `public` keyword automatically creates a free "getter" function for this data.
    mapping(address => Attestation[]) public userAttestations;


    // --- EVENTS ---

    // An `event` is a public signal that the contract emits when something important happens.
    // Dapps and services can listen for these events to get real-time updates.
    event NewAttestation(
        address indexed user,       // The user who received the attestation (indexed for easy searching).
        string actionType,
        address indexed attestedBy  // The platform that gave the attestation (indexed).
    );


    // --- MODIFIERS ---

    // A `modifier` is a reusable security check. This one ensures that only the `owner`
    // can execute a function.
    modifier onlyOwner() {
        // `require` checks if a condition is true. If not, it stops execution and reverts.
        require(msg.sender == owner, "TrustLens: Caller is not the owner");
        _; // The `_` means "if the check passes, proceed with the original function's code".
    }


    // --- FUNCTIONS ---

    // The `constructor` is a special function that runs ONLY ONCE when the contract is deployed.
    // We use it here to set the `owner` to be the address that deploys the contract.
    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Adds a new trust attestation for a user.
     * @dev This is the primary "WRITE" function. It can only be called by the contract owner.
     * @param user The address of the user who performed the positive action.
     * @param actionType A string describing the action, e.g., "positive_review".
     */
    function addAttestation(address user, string memory actionType) public onlyOwner {
        // Creates a new Attestation in memory and pushes it to the user's list in the mapping.
        userAttestations[user].push(
            Attestation({
                actionType: actionType,
                attestedBy: msg.sender, // `msg.sender` here is guaranteed to be the owner.
                timestamp: block.timestamp // `block.timestamp` is a global variable for the current time.
            })
        );

        // Emits the public event to notify the world of this new attestation.
        emit NewAttestation(user, actionType, msg.sender);
    }

    /**
     * @notice Retrieves all attestations for a specific user.
     * @dev This is the primary "READ" function. It is free for anyone to call.
     * @param user The address of the user to query.
     * @return An array of all Attestation structs for that user.
     */
    function getAttestations(address user) public view returns (Attestation[] memory) {
        // `view` means this function only reads data and does not modify the state.
        // This is why it's free to call.
        return userAttestations[user];
    }
}