// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract simple {
    
uint256 public number;

    function add(uint256 _number) public  returns (uint256) {
        number = _number;
        return number;
    }

    function show() public view returns(uint256){
        return number;
    }
}