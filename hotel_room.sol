//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0<0.9.0;
//user will be able to pzy the smart cony=tract to book the hotel room which will automatically open the room ofr them and allow them to aoccupy
 contract hotel_room{

//enm helpsto keep track of the statuses
enum Statuses { Vacant, Occupied}
Statuses currentStatus;
//we re to keep tracjk whether hotel room ids booked or occupied using enum
//vacant or occupied and hence use enum

event Occupy(address _occupant, uint _value);




// ether  modifiers enum and events
//it tid a state variable and bc will know hoe the owner is all thw time
//it is the address where the payment are to be sent when the hotel room is getting booked
address payable public owner;

constructor(){
    owner = payable(msg.sender);
    currentStatus = Statuses.Vacant;
}
//setting the initial satatus to vacant

//we can abstract requirements into mdifiers
modifier onlyVacant{
    require(currentStatus==Statuses.Vacant,"CURRENTLY OCCUPIED");
    _; //This executes the functionbidy
}

modifier costs(uint _amount){
    require(msg.value>= _amount,"NOT ENOUGH ETHER");
    _;
}

//receive will create a function that will be triggered when the smart contract is paid


 receive() external payable onlyVacant costs(2 ether){ 
//    require(msg.value>= 2 ether) //check price
// require(currentStatus= Statuses.Vacant,"currently unAVAILABLE")//check status
currentStatus = Statuses.Occupied; //updates the current status to occupied
owner.transfer(msg.value);// this transfer the amaount of money in this contract to the owner
emit Occupy(msg.sender,msg.value);
 }

 //we can use modifiers in place of require stmnts anfd this we cand add tese modifiers to function
//modifiercare executed before func cll


//events allow externalconsumer sto subscribe to them and find what happens inside the block chain

//using events to createa smart lock taht unlocks a hotel room when something happens

 }
