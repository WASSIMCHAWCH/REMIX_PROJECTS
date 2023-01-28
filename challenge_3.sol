// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract collect {

    uint256 public bidAmount = 1 ether;

    mapping(address => bool) public bid;
    mapping(address => mapping(address => bool)) public isbided;

    address [] public participants;

    address public winner;

    uint256 start = block.timestamp ;
    uint256 luckyIndex ;
    
    function participate() payable external {
         require(block.timestamp - start < 600,"participante full") ;
         require(msg.value == bidAmount, "wrong bid amount");
         require(!bid[msg.sender], "address already in");


        bid[msg.sender] = true;
        participants.push(msg.sender);
      
    }


      function choseWinner( ) external returns(address) {
         require(start > 600,"participante not full");
         require(msg.sender == tx.origin, "only human execution");

         uint256 luckyIndex = block.timestamp % participants.length ;
         winner = participants[luckyIndex];

         return winner;

    }
    

    function claimReward() public {
        require(msg.sender == winner, "not allowed");
        require(block.timestamp - start < 300,"time is over");
        
        payable(msg.sender).transfer(address(this).balance);

        winner = address(0); 

        isbided[msg.sender][address(this)] = false ;

        delete participants;
    }
}