// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract collect  {


    IERC20 public token ;

    uint256 public bidAmount = 10000000000000000000 ;

    mapping(uint256 => mapping(address => bool)) public bid; 
    mapping(uint256 =>uint256) public roundPrize ;
    uint256 public round ;

    address [] public participants;

    address public winner;

    uint256 start = block.timestamp ;



    constructor (address tokenAddress) payable {
        token = IERC20(tokenAddress);

    }
    
     
    function participate() payable external {
         require(block.timestamp - start < 200,"participante full") ;
         require(token.balanceOf(msg.sender) >= bidAmount, "wrong bid amount");
         require(!bid[round][msg.sender], "address already in");


        bid[round][msg.sender] = true;
        token.transferFrom(msg.sender,address(this), bidAmount);
        
        participants.push(msg.sender);
        roundPrize[round] = bidAmount ;
        
    }

      function choseWinner( ) external returns(address) {
         require(start > 200,"participante not full");
         require(msg.sender == tx.origin, "only human execution");

         uint256 luckyIndex = block.timestamp % participants.length ;
         winner = participants[luckyIndex];
         start = block.timestamp ;

         round++ ;

         return winner;

    }

    
    function claimReward() public payable  {
        require(msg.sender == winner, "not allowed");
        
       require (block.timestamp - start < 300);


        token.transfer(winner,token.balanceOf(address(this)) - roundPrize[round] );

        winner = address(0); 

        delete participants;
    }
}
