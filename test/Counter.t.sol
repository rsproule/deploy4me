// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {Create2Deployer} from "lib/create2deployer/contracts/Create2Deployer.sol";

contract CounterTest is Test {
    Create2Deployer deployer;

    function setUp() public {
        deployer = new Create2Deployer();
    }

    function test_deployToCorrectAddress() public {
        bytes32 _salt = bytes32(uint(42));
        uint param = 0;
        bytes memory bytecode = type(Counter).creationCode;
        bytes memory constructorBytecode = abi.encodePacked(
            bytecode,
            abi.encode(param)
        );
        bytes32 codehash = keccak256(constructorBytecode);
        address contractAddressPrecomputed = deployer.computeAddress(
            _salt,
            codehash
        );
        hoax(address(1337), 1 ether);
        deployer.deploy(0, _salt, constructorBytecode);
        Counter counter = Counter(contractAddressPrecomputed);
        assertEq(
            address(counter),
            contractAddressPrecomputed,
            "should deploy to correct address"
        );
    }

    function test_deployShouldPay() public {
        bytes32 _salt = bytes32(uint(42));
        bytes memory bytecode = type(Counter).creationCode;

        bytes memory constructorBytecode = abi.encodePacked(
            bytecode,
            abi.encode(0)
        );
        bytes32 codehash = keccak256(constructorBytecode);
        address contractAddressPrecomputed = deployer.computeAddress(
            _salt,
            codehash
        );
        payable(contractAddressPrecomputed).transfer(1 ether);
        assertEq(
            address(contractAddressPrecomputed).balance,
            1 ether,
            "should have 1 ether"
        );
        uint balanceBefore = address(msg.sender).balance;
        deployer.deploy(0, _salt, constructorBytecode);
        Counter counter = Counter(contractAddressPrecomputed);
        assertEq(
            address(counter),
            contractAddressPrecomputed,
            "should deploy to correct address"
        );
        assertEq(
            address(msg.sender).balance - balanceBefore,
            1 ether,
            "balance of this should increase by 1 ether"
        );
        assertEq(address(counter).balance, 0, "counter should be 0");
    }
}
