// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

abstract contract IncentivizedDeploy {
    constructor(address reciever) {
        if (address(this).balance > 0) {
            payable(reciever).transfer(address(this).balance);
        }
    }
}
