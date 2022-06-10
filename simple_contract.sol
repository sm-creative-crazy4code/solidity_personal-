//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.7;

contract Testcontract{
//simple contract that increment and decrement the value of counter
uint public counter=1;


 function increment() public{
counter++;
// counter+=counter+1;


 }

 function decrement() public{
     counter--;

 }


}
