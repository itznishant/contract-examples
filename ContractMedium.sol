// MEDIUM
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Medium is Ownable {
    string public name = "Contract Medium";

    uint256 private s_totalSupply;

    uint256 private s_initialSupply;

    uint256 public counter;

    constructor(uint256 _initialSupply) {
        s_initialSupply = _initialSupply;
    }

    function increment() external onlyOwner {
        counter++;
    }

    function getTotalSupply() external view returns (uint256) {
        return s_totalSupply;
    }

    function getInitialSupply() external view returns (uint256) {
        return s_initialSupply;
    }
}