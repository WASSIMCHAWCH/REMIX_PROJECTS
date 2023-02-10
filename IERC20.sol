// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Wassim is ERC20("Wassim","WS")  {

            constructor () {
                _mint (msg.sender , 10000000 * (10 ** decimals()));
    }

}

