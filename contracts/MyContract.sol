pragma solidity ^0.4.23;


contract Contract{

  mapping(address => uint) balances;
  
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  
  function Contract(){
      balances[tx.origin] = 10000;
  }


  // The assets that can be traded on the blockchain
  struct Asset{ 
      bytes32 name;
    //   fixed16x4 quantity; // should it be here?
    //   fixed8x2 unitPrice; // should it be here?
      uint quantity;
      uint unitPrice;
  }

 // members of the network trading different assets.
  struct Member{
      bytes32 name;
      address addr;
      Asset[] assets;
      mapping(string => Asset) index;
    //   mapping(address => uint) balance;
  }

  function convert (uint _a) returns (fixed8x4) 
      {
          return fixed8x4(_a);
      }

    //1st verion
  function sendAsset(address receiver, uint amount, Asset asset) public returns(bool sufficient) {
      // each member can only sell his/her asset
      //   if(Member[msg.sender].assets[0].quantity) 

      //sender has enough amount of asset
      if(asset.quantity < amount) return false;

      //receiver has enough amount of tokens.
      if (balances[receiver] < amount*asset.unitPrice) return false;
      balances[receiver] -= amount*asset.unitPrice;
      balances[msg.sender] += amount*asset.unitPrice;

      asset.quantity -= amount;
      emit Transfer(msg.sender, receiver, amount, asset);
      return true;
    }

//   //2nd verion
//   function sendAsset(address receiver, uint amount, Asset asset) public returns(bool sufficient) {
//       // each member can only sell his/her asset
//       //   if(Member[msg.sender].assets[0].quantity) 

//       //sender has enough amount of asset
//       if(asset.quantity < amount) return false;

//       //receiver has enough amount of tokens.
//       if (balances[receiver] < amount*asset.unitPrice) return false;
//       balances[receiver] -= convert(amount)*asset.unitPrice;
//       balances[msg.sender] += amount*asset.unitPrice;

//       asset.quantity -= amount;
//       emit Transfer(msg.sender, receiver, amount);
//       return true;
//     }

//   function SwingContract(address addr, uint balanceVal){
//       this.balance = mapping(addr, balanceVal);
//   }


  function setVal(uint v){
      this.val = v;
  }


}