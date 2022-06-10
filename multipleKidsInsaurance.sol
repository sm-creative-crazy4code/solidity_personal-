//SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.5.0<0.9.0;

contract trust{

  ///thus contract works for more than  one kid.

  //for efficiency we are using structure (like structure in c or c++)
  struct kid{
      uint amount;
      uint maturity;
      bool paid;

  }
  mapping(address=>kid) public kids; //creating a mapping of each d structure against kid
  mapping(address =>uint) public amounts;
   mapping(address =>uint) public maturities;
    mapping(address =>bool) public paid;

//this is the date the kid will br e able to unlock  the ether
address public  admin;

// this is to ensure only admin can call the function addkid
//constructor function is spl as it is onl called once when ewe deploy this contract...sp used to code initialisation logic
constructor(){
admin= msg.sender; ///since constructor is called only once admin cannot be reinitiaized
}


function addKid( struct kid , uint timeTomaturity) external payable{
  require(msg.sender== admin,"only admin alowed");
  require(kids[msg.sender].amount==0," this kids already exists");//to ensure the same kid is not added twice
  kids[kid]=kid(msg.value,block.timestamp+timeTomaturity,false); //onotialising all dATA elements of kid
}

function withdraw()external {
    //defining kid to our contract
    //we are creating a variable of type kid and then assigningthe aaddress of each account to it
    kid storage KID =  kids[msg.sender];

    //kid>>data type.....KID>>>variable name


    //here we are accessing each data element of structure kid using variable KID and hence checcking the fallowing conditions


    //this ensures kid cannot withdraw the money unless the block time has reached te maturity value ie he has ccrossed a particular age
    require(KID.maturity<=block.timestamp,"too early to withdraw");
    require(KID.amount >0," only kiid s can withdraw");//address of each kid is mapped  against an int and amaount [msg,sendwer ] returns that uint if the addresss is mapped in amount mapping.if the address is not present in mapping the default value of uint ie 0 is returned
   
    //to prevent the same kid from withdrawing money again and again
  require(KID.paid=false," already"); //since by default bool is already init.to false so we is the kid hasnot yet called the functonso he will be assinged false value'' once this function is called we assignr=ed the value true to the adress.hence if the same address tries to clll the function once again he  wont be able to take the money 
  KID.paid[msg.sender]=true;

  payable (msg.sender).transfer(KID.amount);
//   address,address payable;  making the address of kid payable so taht they can be paid.
//an address can only send ethers to a payable address
    //address(this).balance);>>gives the balance present in the contract
    //msg.sender.transfer(address(this).balance);>> his lines means that transfer all the balnce present in this contract to the msg.sender ie the caller of this function
}


//every time we re calling the functions here we are interacting with the etherium network.we are sending a transaction to etherium network and wwe need to pay the transaction fee.
//in units known as gasss


//gass cost for  our smart contract should be as low as possible. hence we are trying to mad ethe code more efficient

}
