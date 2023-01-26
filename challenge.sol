// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract collect {

    uint256 public bidAmount = 1 ether;

    mapping(address => bool) public bid;

    address[] public participants;

    address public winner;

    uint256 start;
    
    function participate() payable external {
         require(msg.value == bidAmount, "wrong bid amount");
         require(participants.length < 4, "game ended!");
         require(!bid[msg.sender], "address already in");

        bid[msg.sender] = true;

        participants.push(msg.sender);

        if(participants.length == 4){
            start = block.timestamp;  //number of secs from 1/1/1970 utc
        }
    }

    function choseWinner( ) external returns(address) {
        require(start > 0, "game still on");
        require(block.timestamp - start >= 60, "60 secs wait");
        require(winner == address(0), "winner already chosen");
        require(msg.sender == tx.origin, "only human execution");

        uint256 luckyIndex = block.timestamp % 4;

        winner = participants[luckyIndex];
        return winner;
    }

    function claimReward() public {
        require(msg.sender == winner, "not allowed");
        
        payable(msg.sender).transfer(address(this).balance);

        winner = address(0);
        start = 0;
        for(uint256 i=0; i<participants.length; i++){
            bid[participants[i]] = false;
        }
        delete participants;
    }
}