//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.90;

contract Lottery {
    address public manager;
    address payable[] public participants; //dynamic array

    constructor(){
        manager= msg.sender; // it is a gkobal variable when we tranfer amount from any particular account to a contract the address will be stored in variable manager.
    }
    //msg.sender is used to store the address of sender in a given variable 
    //making function to receive payments
    //received is a special type of function that can be only used once in the contract.
    //we always use external key word with received.we cannot pass arguments to received.
    receive() external payable{
        require(msg.value==1 ether);//works just like if else statement but is a short hand method of riting. here used to set participation criteria,if thr required condition is met next line of code is executed.
        participants.push(payable(msg.sender)); //the particular address of participant is pushed into the dynamic array of participants
    }
    //getbalance gives information about balancde in the contract,
    function getBalance() public view returns (uint){
        require(msg.sender==manager);//msg.sender is like the address. here it is checking whether manager only is enquiring about balance or not.only manager address can enquire about balance
         return address(this).balance ;
    }
    //function to generate random function.we should very carefully use them else we may face losses
    //****8**8**88****donot use this method to generate random values in actual smart contracts. it is very risky and u may face losses.*********************
    function random() public view returns (uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length))); //keccad is used to help to seclect a random player.participants.length is used to transfer the length of array into the function. 

    }
    //the above function generates very big random no. but we need random no in range of index of no participants as  we have to choose the winner among them only.hence we need to select the random no in range of  index of array participants by building a logic as shown below.
   function seclectWinner() public {
       require(msg.sender==manager);
       require(participants.length>=3);
       uint r=random();
       address payable winner;
       uint index= r% participants.length;
       winner=participants[index];
       winner.transfer(getBalance());
       //the below code resets the dynamic array to become empty once the function has been called so that new participants can enter the lottery.
       participants=new address payable[](0);


   }





}
