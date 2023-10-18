// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Counter} from "src/Counter.sol";
import {Create2Deployer} from "../lib/create2deployer/contracts/Create2Deployer.sol";

contract FundTargetScript is Script {
    Create2Deployer deployer;

    function setUp() public {
        deployer = new Create2Deployer();
    }

    function run() public {
        vm.startBroadcast();
        bytes32 _salt = bytes32(uint(42));
        bytes memory bytecode = type(Counter).creationCode;
        bytes memory constructorBytecode = abi.encodePacked(
            bytecode,
            abi.encode(1337)
        );
        bytes32 codehash = keccak256(constructorBytecode);
        address contractAddressPrecomputed = deployer.computeAddress(
            _salt,
            codehash
        );
        // TX1
        payable(contractAddressPrecomputed).transfer(1 ether);
        // TX2
        deployer.deploy(0, _salt, constructorBytecode);
    }
}
