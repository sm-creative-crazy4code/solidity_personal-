//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract VendingMachine{
    //address is var in solidity>> 20 bytes >> hilds eth address>> thus will hold address of the o
    
address public owner;
//meew datatype in solidity we link or mapp datas of same type>>like objects in javascript>> but they must be of same type
//mapping address of account against the donut each of them own
mapping(address => uint)  public donutBalances;

// constructor can be called only once so here we set that by using owner = msg.sender  we say that owner can only call the function
constructor(){
    owner=msg.sender;
    // sender is the eth address of the originator of the function or the account which calls the function

    //setting initial donut balancee for donut machinr of 100;
    //here we are mapping the address of THIS contract against the Value 100 ie this contract initialy has 100 balance
    //this  mapping also holds info of other users also
    donutBalances[address(this)]=100;
}
function getVendingMachineBalance()public view returns(uint){
//func returns uint to represent the number of donuts
//view>>func cannot modify data but can read data from block chain

return donutBalances[address(this)];
// the above code says to reurn the uint type value of donuts associated with balance of this address
}


//function to add more donuts to vending machine by owner when vm is empty
function restock(uint amount) public{
    //this functin must only be invoked by owner of contract//use require stmt
    //syntax r>>>>require(condition, code torun when condition is not met.)
require(msg.sender==owner,"only owner can restock");//msg.sender the adress of the account calling the function >>>by using require(msg.sender==owner) we r restricting the conditiom that the function must proceedto next iteration only if msg.sender returns the address of the owner ie only owner can calll this function
    //we are actually modifying data on block chain by updating state variable amount...the function is not marked as view or pure
    donutBalances[address(this)]+=amount;
    }

    //final purchase function
    //payable function is used for functions which require to receuve ethers
    //transactionwill be reverted if dont have this keyword
    function purchase(uint amount) public payable{
        //require stmt to check that amount coming in is equal or greater than price of donut
        require(msg.value >= amount * 2 ether,"you must pay 2 eth per donut");
        //msg.value returns the money sent to this function of this contract
        //function to check enough donuts ids present to suppply the buyer.
        require(donutBalances[address(this)]>=0," SORRY!!!not enough donuts for supply");

        //decrement dnm balance
        //increment buyers balance
        donutBalances[address(this)]-=amount;
        donutBalances[msg.sender]+=amount;
        //here msg.sender refers to the address of the purchaser because here the purchaser is initiating the function call



    }



}





///sate var stored in smart contract eth
// constroctor called once
