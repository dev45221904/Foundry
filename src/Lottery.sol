//----------------------------------------------------------------Dev Was Here----------------------------------------------------------------

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery{

    address immutable owner;

    uint256[] public tickets = [11293, 11246, 11563, 11111, 11456];

    uint256[] private sold;

    uint256 constant price = 1e15;

    uint256 private winner = 11111;

    error BetterLuckNextTime(string _err);

    error NotScratched(string _notscratch);

    struct Player{
        string name;
    }

    Player[] public players;
    
    mapping (address => bool) public HasBought; // 1 ticket per user...

    mapping(address => uint256) public BoughtTicket;

    // mapping(address => bool) public HasScratch;

    constructor() {
        owner = msg.sender;
    }

    function buy(string memory _name, uint256 _ticket) public payable {

        require(!HasBought[msg.sender], "Already Bought 1, Cannot buy more");
        require(msg.value == price, "please enter the valid amount");
        require(_ticket < tickets.length, "mention valid ticket Sequence");
        require(tickets[_ticket] != 0, "SOLD!!");

        uint256 TheChosenOne =(tickets[_ticket]);
        sold.push(TheChosenOne);
        delete tickets[_ticket];
        BoughtTicket[msg.sender] = TheChosenOne;

        HasBought[msg.sender] = true;
        players.push(Player( _name));
    }

    function ScratchTheCard() public view returns(uint256){
        require(HasBought[msg.sender], "Buy the ticket first");
        return BoughtTicket[msg.sender];

        
    }

    function Winn() public returns(string memory){

        require(HasBought[msg.sender], "Not bought any ticket");

        // require(HasScratch[msg.sender], "Please scratch!");
        uint256 Lucky = ScratchTheCard();

        if(Lucky == winner){
            (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
            require(success, "Transfer failed");
            return "You've won!!";
        }
        else{
           revert BetterLuckNextTime("Better Luck Next Time!");
        }
    }
}