// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ContractMedium is Ownable {
    ///////////////////
    // State Variables
    ///////////////////
    bytes32 private immutable i_name;

    uint256 private s_totalSupply;

    uint256 private s_initialSupply;

    uint256 public counter;

    ///////////////////
    // Functions
    ///////////////////
    constructor(uint256 _initialSupply) {
        s_initialSupply = _initialSupply;
        i_name = "Contract Medium";
    }

    function increment() external onlyOwner {
        counter++;
    }

    ///////////////////
    // Getter Functions
    ///////////////////
    function getTotalSupply() external view returns (uint256) {
        return s_totalSupply;
    }

    function getInitialSupply() external view returns (uint256) {
        return s_initialSupply;
    }

    function getName() external view returns (string memory) {
        return string(abi.encodePacked(i_name));
    }
}
