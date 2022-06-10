//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract  vaultcontract{

    struct Vault{
        address creater;
        string name;
        address[]users;//dynamin array
        uint amount;
        }

 uint totalvaults;//how many vaults are inthe system
 mapping(uint=>Vault) public vaults;//mapping each valut against an integer
 //1 assigned to a vault ...2 assigned to a diiferent vault...and each of this comes from the struct vault

mapping(address=>uint) public balance;
///maping the address of the user against the amount they hanve been assigned

////whenever the function is called any body in blockchain can see it 
event Vaultdistribution(uint vaultid , uint amount);



///function to create vault
//it returns  vault id which we would use in the mapping vaults to check wha t inside the vault
//eg if 1 is returned as vault id we use it in mapping..( it will create a getterfunction at user interface and if we type 1 into that we get vault value)

function createVault(string memory name, address[]memory users,uint initialamount) public returns (uint vaultid) {
    Vault storage vault = vaults[totalvaults];///creating a variable vault of datatype Vault  .
    //we are using the map the value of the vault againt an uint that ishere total vault
    //uisng totalvault as uint and getting a vault for that uint

    vault.creater=msg.sender;//vault .creater is assigned the address of the one who call the function
    vault.users=users;
    vault.name=name;
    vault.amount=initialamount;

    totalvaults+=1;

    ///we are basically mapping the valute against each index of totals vaults
  // vaults contain all user input data toset it variables and hence we are creating the vault

return totalvaults-1;//this sets the vault id to 0
///this function only assigns a given argument sto the respective vault members
}
 
//we obtained the vult id from the previous function by maimg a vault

function addAmount(uint vaultid, uint amount) public{
  Vault storage vault= vaults[vaultid];//we are accessingthe storage using the vault id
  //in order for the next line of code to be executref the require condition must be true..ie the msg,sender od the one calling the function must be creater of the vault
  require(msg.sender==vault.creater,"not vault owner");
  vault.amount +=amount;

}
 function distribute(uint vaultid ) public{
    Vault storage vault= vaults[vaultid];
    require(vault.users.length!=0);
    uint amountPerUser=vault.amount/vault.users.length;/// it devides the amount present in a vault by the total no. of users
    //user.length -->gives length of the array users.
   // vault.user.length;--> length of the array user whch is present in  variable vault of type structure
   if(vault.amount!=0){
for(uint8 i; i< vault.users.length;i++){
  vault.amount-=amountPerUser;//distributing each user the amount he gets 
balance[vault.users[i]]=amountPerUser;// mapping the each user against the vault amount they had received
}
   }
   else{
     revert("no funds remining");
   }
emit Vaultdistribution(vaultid,amountPerUser*vault.users.length);
//event -> declares an event
//emit-> procalls an event

 }

}
