//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.7;
contract remotepurchase{
uint public value;
address payable public seller;//both address are made payabale since both are going to receive funds
address payable public buyer;

enum State{Created,Locked,Released,Inactive}//by default Created=0, Locked=1,Realesed=2 and so on
//creating a variable named state of state type using the enum
State public state;///by defult it will be assigned with created value ie the first value

//constructor function is a function that is invoked once when the contract is deployed to etherium. good for initialsation code
constructor() payable{
    //setting the seller as one who deploys the contract
    seller= payable(msg.sender);
    //msg.sender returnds the adress which call the function
    //since constructor function is a function that is invoked once when the contract is deployed to etherium msg.sender in constructor returns the adress that DEPLOYED the contract
    //msg is a global variable  and by default it is not payable so it has been typecasted to payable
    value=msg.value/2;

}
//function that allows the buyer to send money to the contract and designates him as a buyer

//since the buyer need to invoke the function from outside the contract we set is as external



//creating MODIFIERS to check the conditions to run the function is met or not
//MODIFIERS is a separate entity or function we can add in the function to qualify this function in order to restrict this function to satisfy the terms of modifier

//Modifier will call the revert function if the condition isnt met and the revet function will call in custom erors

//defining yhe error function

//napstac eror syntax below; writing the rerror msg string right abovr tthe function


///The state is invalid for the function to be called
error InvalidState();

///only the buyer can call this function
error Onlybuyer();


modifier inState(State state_){
    //this takes state DATAtype as an argument
    //if state is not same as the state we are quwationing for tehn the revert function must be called
    if(state != state_){
        revert InvalidState();

    }
    _; //this signifies that execute theh rest of the function that modifier is applied to
}

modifier onlyBuyer{
    if(msg.sender!=buyer){
        revert Onlybuyer();
    }
    _;

}


//applying the modifier to aou confirm purchase function using the below syntax and passing is the require argument state. created and hence whetherthe contract is in creaed state or not



function confirmPurchasepayable()external inState(State.Created) payable{
    require(msg.value==(2*value),"pls send in 2X the purchase value");
    buyer=payable(msg.sender);//here the adress of ehoever called this fuction is assigned as buyer
    state=State.Locked;//stae is set to locked state

}

//setting up a function only buyer can invoke after the had received the product and so their funds must be released now

//we need to check that before caaling the below function whether the state is in locked state or not  and hence we are again using our in state modifier
//we also set up a 2 nd modifier to check whether the request is being done by buyer or not
//written the  2 nd coustum error msg  below the error function using napstack syntax containing 3/ ie (///)

function confirmReceived() external   onlyBuyer inState(State.Locked)  {
    //example for protection fronm re entrancy attack
    //we need to update the state first and to prevent some tfrom invoking the same contract again and again
    state=State.Released;
    buyer.transfer(value);//tis codes transfeer the security amount to the buyer

}


///only the seller can call this function
error OnlySeller();

modifier onlySeller{
    if(msg.sender!=seller){
        revert Onlybuyer();
    }
    _;

}

// modifier OnlySeller{
//     if(msg.sender!=seller){
//         revert Onlyseller();
//     }
//     _;
// }


//this function needs to be only invoked by seller and hence we creaed a coustim erroe msg as above to display the errpr if the function is not invoked by seller and creating modifier for the same
function paySeller() external onlySeller inState(State.Released){

state=State.Inactive;
seller.transfer(3*value);
}


function abort() external onlySeller inState(State.Created){
    //first updating the state
    state=State.Inactive;
    seller.transfer(address(this).balance);



}


}
