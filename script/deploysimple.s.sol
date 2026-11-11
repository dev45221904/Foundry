// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {simple} from "../src/simplecontract.sol";

contract deployer is Script{

    function run() external returns(simple){
        vm.startBroadcast();

        simple simp = new simple();

        vm.stopBroadcast();

        return simp;
    }
}