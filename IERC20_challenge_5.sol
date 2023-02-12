// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Wassim is ERC20("Wassim","WS")  {
            address payable owner ;

            constructor () payable {
                uint256 supply25 = ( 10000000 * (10 ** decimals()) ) / 4 ;
               _mint (0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 ,supply25 );
                _mint (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,supply25);
                 _mint (0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,supply25 * 2) ;
                owner = payable(msg.sender) ;
    }
}

