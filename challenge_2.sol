// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract collect {

    uint256 public bidAmount = 1 ether;

    mapping(address => bool) public bid;

    address[] public participants;

    address public winner;

    uint256 start ;
    uint256 luckyIndex;
    
    function participate() payable external {
         require(msg.value == bidAmount, "wrong bid amount");
         require(participants.length < 4, "game ended!");
         require(!bid[msg.sender], "address already in");

        bid[msg.sender] = true;

        participants.push(msg.sender);
    }


    fallback() external payable {
        require(winner == address(0), "winner already chosen");
        require(msg.sender == tx.origin, "only human execution");
        
        if (participants.length == 4) {
        luckyIndex = block.timestamp % 4;
        }


        winner = participants[luckyIndex];
        start = 0;
        start = block.timestamp ;
        
    }


    function claimReward() public {
        require(msg.sender == winner, "not allowed");
        require(block.timestamp - start < 300,"time is over");
        
        payable(msg.sender).transfer(address(this).balance);

        winner = address(0); 
        for(uint256 i=0; i<participants.length; i++){
            bid[participants[i]] = false;
        }
        delete participants;
    }
}