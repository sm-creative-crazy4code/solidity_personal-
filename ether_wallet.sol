///SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract EtherWallet{
address payable public owner;
//payable--> to receive ether
//public-->visible to everyone outside  and  inside cntrct in bc



//constructor runs one time during inituailization of contract and goodfor writing some initialization code
constructor(){
owner= payable(msg.sender);
}
//msg is a global variable...msg.sender gives the addrress of one who calls the function. since constructor function is being called msg.sender gives the address of one deployingthe contract

//by defauklt msg.sender is not pauyable and hence we typecasted it to payable type


//receie is a default function that allows the function to receive funds
//smart contract can act like a normal wallet and receive funds
receive() external payable {}


function withdraw (uint _amount) external{
    require(msg.sender==owner,"only owner is allowed") ;// checks if the owner is calling the function or not
    payable(msg.sender).transfer(_amount);
}
//external -->can de called outside smart contract
//view--> can only read data from the block chain
function getBalance() external view returns (uint){
return address(this).balance;//this syntax returns the current balance of the current smart contract
}



}


