contract Exchange{
  function deposit(uint,uint,uint) returns (uint);
}

contract GasCoin{
  Exchange exchange;
  string id;
  address owner;
  mapping(address => uint) public balances;
  function GasCoin(address exchange, string marketId, address owner){
    exchange = Exchange(exchange);
    id = marketId;
    owner = owner;
  }

  function set_exchange(address addr, string ID) public{
    if(msg.sender == owner){
      exchange = Exchange(addr);
      id = ID;
    }
  }

  function transfer(address recipient, uint amount)public returns (bool){
    if (balances[msg.sender] >= amount){
      balances[msg.sender] -= amount;
      balances[recipient] += amount;

      if(recipient == address(exchange)){
        var ret = exchange.deposit(msg.sender,amount,id);
        if (ret >= amount) return true;
        else return false;
      }
      return true
    }
    return false
  }
}
