contract Timer{
  address call;
  uint gas;
  uint32 freq;
  uint last;
  address owner;
  GasCoin coin;
  bytes4 sig;
  struct Worker {
    address addr;
    uint deposit;
    bool working;
    uint8 notice;
  }
  mapping(address => Worker ) workers;
  function Timer(address gascoin,address callback, bytes4 functionSig, uint gasLimit, uint frequency){
    call = callback;
    gas = gasLimit;
    freq = frequency;
    owner = msg.sender;
    sig = functionSig;
    coin = GasCoin(gascoin);
  }

  function public destroy(){
    if(msg.sender == owner){
      coin.refund();
      suicide(address(coin));
    }
  }

  function public execute(){
    if (workers[msg.sender].working){
      if(msg.gas >= gas){
        if(block.number >= last+freq){
          call.call(sig);
          last = block.number;
          coin.pay(gas,msg.sender);
        }
      }
    }
  }
  function registerWorker() public {

  }
}
