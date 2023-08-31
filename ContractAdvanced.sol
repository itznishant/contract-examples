// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Pausable} from "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title Contract Advanced
 * @author Nishant V
 * @notice This is a professional contract which incorporates named imports, custom errors, events and modifiers.
 * @dev Sample information.
 */

contract ContractAdvanced is Ownable, Pausable {
    ///////////////////
    // Custom Errors
    ///////////////////
    error ContractAdvanced__InputAExceedsThreshold();
    error ContractAdvanced__InputBExceedsThreshold();
    error ContractAdvanced__ResultExceedsThreshold();
    error ContractAdvanced__MemberNotFound();

    ///////////////////
    // State Variables
    ///////////////////
    uint16 public constant SECONDS_IN_ONE_HOUR = 3600;

    address private immutable i_owner; // Gas Saver: Much Cheaper => Injected into contract Bytecode

    // @dev Mapping of member addresses to boolean
    mapping(address => bool) private s_isMember;

    struct Member {
        string firstName;
        string lastName;
        address memberAddr;
    }

    Member[] members;

    ///////////////////
    // Events
    ///////////////////
    event memberAdded(address indexed memberAddress);
    event memberRemoved(address indexed memberAddress);

    ///////////////////
    // Modifiers
    ///////////////////

    // onlyOwner

    ///////////////////
    // Functions
    ///////////////////
    constructor() {
        i_owner = msg.sender;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    /////////////////////
    // External Functions
    /////////////////////
    /*
     * @notice Follows CEI pattern
     * @param _firstName: First name of member to be added, should NOT be blank.
     * @param _lastName: Last name of member to be added, can be blank.
     * @param _memberAddr: Address of the member to be added.
     * @notice Warning! Calling this removes a valid member from the member mapping permanently.
     */

    function addMember(
        string memory _firstName,
        string memory _lastName,
        address _memberAddr
    ) external onlyOwner whenNotPaused returns (bool) {
        members.push(Member(_firstName, _lastName, _memberAddr));

        s_isMember[_memberAddr] = true;

        emit memberAdded(_memberAddr);

        return true;
    }

    /*
     * @notice Follows CEI pattern
     * @param _memberToRemove: address of the member to be removed.
     * @notice Warning! Calling this removes a valid member from the member mapping permanently.
     */
    function removeMember(address _memberToRemove)
        external
        onlyOwner
        whenNotPaused
        returns (bool)
    {
        // Delete does not change the array length.
        if (!s_isMember[_memberToRemove])
            revert ContractAdvanced__MemberNotFound();

        for (uint8 i; i < members.length; ) {
            if (members[i].memberAddr == _memberToRemove) {
                delete members[i];
            }

            unchecked {
                ++i;
            }
        }

        s_isMember[_memberToRemove] = false;

        emit memberRemoved(_memberToRemove);

        return true;
    }

    function addNumber(uint8 a, uint8 b)
        external
        view
        onlyOwner
        whenNotPaused
        returns (uint8)
    {
        if (a > 10) revert ContractAdvanced__InputAExceedsThreshold();
        if (b > 10) revert ContractAdvanced__InputBExceedsThreshold();

        uint8 result = a + b + 1;

        if (result > 20) {
            revert ContractAdvanced__ResultExceedsThreshold();
        }

        return result;
    }

    ///////////////////
    // Getter Functions
    ///////////////////
    function getOwner() external view returns (address) {
        return i_owner;
    }

    function getValidMember(address memberAddress)
        external
        view
        returns (bool)
    {
        return s_isMember[memberAddress];
    }

    function getMemberDetails(uint8 memberIndex)
        external
        view
        returns (
            string memory firstName,
            string memory lastName,
            address memberAddr
        )
    {
        return (
            members[memberIndex].firstName,
            members[memberIndex].lastName,
            members[memberIndex].memberAddr
        );
    }
}
