// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {Lottery} from "../src/Lottery.sol";

contract deployer is Script{

    function run() external returns(Lottery){
        vm.startBroadcast();

        Lottery Game = new Lottery();

        vm.stopBroadcast();

        return Game;
    }
}