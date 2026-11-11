// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {Vote} from "../src/vote.sol";

contract  deploy is Script {
    constructor() {
        
    }

    function run() external returns (Vote) { 
        vm.startBroadcast();

        Vote vote = new Vote();

        vm.stopBroadcast();

        return vote;
    }
}