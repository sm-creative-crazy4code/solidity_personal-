//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0<0.9.0;
contract crud{


//only type declaration and not itration of struct
struct User{
    uint id;
    string name;
}
User[] public users;
// to add new users to the array we need to keep track of the nextv i id feild to add the next user
//we need to keep incrementing the id as well hence teh var nextId
uint public nextId = 1;
function create( string memory name) public{
users.push(User(nextId,name));//passingthe parameters serially to th estructure so that they get assigned accordingly
//users details is now stored in the array
nextId++;

}


//we can call a function und=side a function in solidity but sometimes it costs more gas 

function read(uint id) view public returns( uint Id, string memory name) {
    // for( uint i=0; i < users.length; i++){
    //     if(users[i].id==id){
            uint i= find(id);
            return(users[i].id,users[i].name);
        

        //function for updating the id 


    }



//function to update name corresponding to id
function update( uint id, string memory name) public{
//   for( uint i=0; i < users.length; i++){
//         if(users[i].id==id){
               uint i= find(id);
            users[i].name=name;
}

function deletion (uint id) public {
     uint i= find(id);
    delete users[i]; //delete key word is used to delete an entry of array
}

//returns the position of user in the users array
//internal function can only be called from inside the smart contract
function find( uint id ) view internal returns (uint position){
     for( uint i=0; i < users.length; i++){
        if(users[i].id==id){
            return i;
        }
}//condition to cgive feedback when the id we want to delete doesnot exist
//revert is like throwing an error in js
//the prog, execotion stops and a error msg is displayed
//in case of transaction any staate change in transaction is cancelled and all the gas used in trabsaction is wasted
revert('user does not exist');

}
// if we delete 1st user and try to read its feild
//in sol if we try to acces a struct that doesnot exist we cann still read its feild and its feild is initialized to its default value
//we initialized  next id to i so that we never have a user with id 0 and hence id cannot have default value 0
}
