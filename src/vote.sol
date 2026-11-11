// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote {
    address immutable owner;

    struct Voters {
        address person;
        uint256 GotVotes;
        uint256 balance;
    }

    mapping(address => uint256) public showbal;
    mapping(address => bool) public IsRegistered;
    mapping(address => bool) public VoteCount;
    mapping(address => uint256) public RegisteredCount;

    event MakeVote(address indexed person, uint256 indexed votedto);

    Voters[] public voters;

    constructor() {
        owner = msg.sender;
    }

    function register(address _person) public payable {
        require(msg.value >= 1e18, "To register yourself you should deposit atleast 1 ETH to this contract");
        uint256 balance = msg.value;
        uint256 GotVotes = 0;
        voters.push(Voters(_person, GotVotes, balance));
        showbal[_person] = balance;
        IsRegistered[_person] = true;
        RegisteredCount[_person]++;
    }

    function vote(uint256 _to) public {
        require(IsRegistered[msg.sender], "not registered");
        require(!VoteCount[msg.sender], "already voted");

        VoteCount[msg.sender] = true;

        Voters storage count = voters[_to];
        count.GotVotes++;

        emit MakeVote(msg.sender, _to);
    }

    function determine() public view returns (address winner, uint256 highestVotes) {
        for (uint256 i = 0; i < voters.length; i++) {
            if (voters[i].GotVotes > highestVotes) {
                highestVotes = voters[i].GotVotes;
                winner = voters[i].person;
            }
        }
    }
}