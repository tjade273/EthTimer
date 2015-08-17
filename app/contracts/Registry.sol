contrat TimerContract{
  function TimerContract(){

  }
}



contract Registry{
  string public version;
  struct timer {
    address owner;
    address callback;
    uint gasLimit;
    uint balance;
    uint32 frequency;
    uint32 end;
  }
  address[] owners;
  mapping(address => mapping(string => TimerContract)) contracts;
  function Registry(string ver) returns (bool){
    version = ver;
    return true;
  }

  function setTimer(string name, uint32 frequency, uint32 duration,uint gas,address callback){
    timer time;
    time.owner = msg.sender;
    time.callback = calllback;
    time.end = block.number + duration;
    time.frequency = frequency;
    time.balance = msg.value;
    time.gasLimit = gas;
    timeContract = new TimerContract(time.owner,time.callback,time.end,time.frequency,time.balance,time.gasLimit);
    owners[msg.sender][name] = timeContract;
    return address(timeContract);
  }
  function clearTimer(string name){

  }
}
