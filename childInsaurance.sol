//SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.5.0<0.9.0;

contract trust{

  ///thus contract works for only one kid.
address public kids;
uint public maturity;//this is the date the kid will br e able to unlock  the ether

//constructor function is spl as it is onl called once when ewe deploy this contract...sp used to code initialisation logic
constructor(address _kids,uint timeTomaturity ) payable{
//payable>> so tht w ecan send money to smrt cnrct.
maturity=block.timestamp+timeTomaturity;
kids=_kids;
}

function withdraw()external {
    //this ensures kid cannot withdraw the money unless the block time has reached te maturity value ie he has ccrossed a particular age
    require(block.timestamp>= maturity,"too early to withdraw");
    require(msg.sender==kids," only kiid s can withdraw");//msg.sender returns the address of who is calling this function. so thus we are only allow kids to call thwe function  by checking the condition.
  payable (msg.sender).transfer(address(this).balance);
//   address,address payable;  making the address of kid payable so taht they can be paid.
//an address can only send ethers to a payable address
    //address(this).balance);>>gives the balance present in the contract
    //msg.sender.transfer(address(this).balance);>> his lines means that transfer all the balnce present in this contract to the msg.sender ie the caller of this function
}


}
