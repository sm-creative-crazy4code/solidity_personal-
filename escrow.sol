//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0<0.9.0;

//escrow= solves the issue of trust in a smart contract by involving a third party in it
contract escrow{

   //this acct as a ageny 
   //agent is a state variable..its address is actually stored in block chain
   address agent; //this csn only withdrw or deposit funds from the smart contract


 //we added it to keep track of all the tractions taht are being deposited into the contract  
mapping(address=>uint256) public deposits;
 //creating a modifier to ensure that only the escrow is allowed to withdraw and deposit fubnds


modifier onlyAgent(){
    require(msg.sender==agent);
    _;
}
//function modifier get s added to a function that checks the require condition whwnever the function is called
//if require condition is flse it can revert tje transaction

   constructor(){
   agent= msg.sender;//this is for setting the address of one who deploys the contract as the agent
//agent is ne who deployed the smart contract and hence allowed to call its functions
}

//agent can actually deposit funds in the smart contract and actually make sure thta they get paid to the right person
function deposit(address payee)  payable  public onlyAgent {
    uint256 amount= msg.value;
    deposits[payee] = deposits[payee] + amount;
}
//withdraw funds and payee to the payee
function withdraw (address payable payee) public onlyAgent{
    uint256 payment = deposits[payee];
    deposits[payee]=0;
    payee.transfer(payment);//sends the fund to payee
}

}
