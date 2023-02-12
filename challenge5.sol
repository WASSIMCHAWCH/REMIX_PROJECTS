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

contract wassim {
    IERC20 public token ;



    mapping (address=>uint256) public accounts ;

        constructor (address tokenAddress) payable {
        token = IERC20(tokenAddress);
    }


    function deposit (uint256 amount) external {
        require(token.balanceOf(msg.sender) >= amount, "wrong amount");

        token.approve(address(this) , amount);
        token.transferFrom(msg.sender , address(this), amount ) ;
        accounts[msg.sender] +=  amount ;
        
    }

    function withdraw (uint256 amount) public {
        require(accounts[msg.sender] >= amount ,"wrong account");

        token.transfer(msg.sender , amount) ;
        accounts[msg.sender] -=amount ;
    }


}
