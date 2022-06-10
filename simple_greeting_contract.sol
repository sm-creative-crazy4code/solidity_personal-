//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.11;
 

///create and display a greeting
contract Greeting{

//declaring state variable that will persisit in the block chain and will be invoked multiplr times in the contract

// evevn if we declare the variable as private it will still be visible as on block chain everything is visible
//whenever we declare a state variable we get a getter function by default
string public name;
string public greetingPrefix="hello";


//declaring cnstructor function t9o set the namre


//IMPORTANT POINTS;
//STORAGE->stored in block chain
//MEMORY->stored in memory and exists while the function is called, it is erased when function does not exist
//CALLDATA-> special data location that contains function argument only available too external function
constructor(string memory initialName){

    name=initialName;
}
//function to set the name gain in furture

//public funmn can be called by any other function in the smart contract
function setName(string memory newName) public{
    name= newName;
}

//getter function to display the greeting


//view =doesnt change daata on block chain
//pure= doesnot change as well assead data on block chain
function getGreeting() public view returns(string memory){
    return  string (abi.encodePacked(greetingPrefix, name));
//here we are concatinatimg 2 strings using there abi codes and the tyoecasting it as a string again
}


}
