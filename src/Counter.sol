// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IncentivizedDeploy} from "src/IncentivizedDeploy.sol";

contract Counter is IncentivizedDeploy {
    constructor() IncentivizedDeploy(tx.origin) {}

    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
