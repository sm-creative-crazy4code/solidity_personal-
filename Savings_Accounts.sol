//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.5;


//alows us to put money in the contract and withdraw  after a specific period of time
contract Timelock{
    //lock up  crypto in this smart contract for a specific person
    //who can withdraw and how muh and when



    //solidity allows to store data in block chain inside state variables
    address payable benificiary;
    uint releaseTime;
//_benificiary is a local variable while benificiary is a state variable
//constructor is called only once when the block chain is deployed'
    constructor(address payable _benificiary, uint _releaseTime )  {
        //block.timestamp gives the  time whwn the block has bee actually created in seconds
        require(_releaseTime > block.timestamp);
       benificiary = _benificiary ;
       releaseTime= _releaseTime;
    }
    //constructor is now capable of storinf=g any vaue we send and it will be able to pay the benificiary

    // in block cj-hian for timre we use unix timestamp and it tells what time in seconds since this specific point history ie from the time when the block is being deployed
function release() public{
    //transfering ether to benificiary
   
    require(block.timestamp>= releaseTime);
    benificiary.transfer(address(this).balance);
}



}
