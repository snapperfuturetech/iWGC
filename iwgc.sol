pragma solidity ^0.4.19;contract Token {    function balanceOf(address _owner)  public constant returns (uint256 balance) {}    function transfer(address _to, uint256 _value) public  returns (bool success) {}    function transferFrom(address _from, address _to, uint256 _value) public  returns (bool success) {}    function approve(address _spender, uint256 _value)  public returns (bool success) {}    function allowance(address _owner, address _spender)  public constant returns (uint256 remaining) {}    event Transfer(address indexed _from, address indexed _to, uint256 _value);    event Approval(address indexed _owner, address indexed _spender, uint256 _value);    event Changeetherwallet(address indexed _etherwallet,address indexed _newwallet);}contract Ownable {    int dummyVar;    address public owner;    function Ownable() {        owner = msg.sender;    }    modifier onlyOwner() {        require(msg.sender == owner);        _;    }        function shutdown() onlyOwner {        selfdestruct(owner);    }  }contract StandardToken is Token {    function transfer(address _to, uint256 _value) public returns (bool success) {      //  if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {        if (balances[msg.sender] >= _value && _value > 0) {            balances[msg.sender] -= _value;            balances[_to] += _value;            Transfer(msg.sender, _to, _value);            return true;        } else { return false; }    }    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {        //if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {        //?if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {            if (balances[_from] >= _value  && _value > 0) {            balances[_to] += _value;            balances[_from] -= _value;            allowed[_from][msg.sender] -= _value;            Transfer(_from, _to, _value);            return true;        } else { return false; }    }    function balanceOf(address _owner) constant public returns (uint256 balance) {        return balances[_owner];    }    function approve(address _spender, uint256 _value) public returns (bool success) {        allowed[msg.sender][_spender] = _value;        Approval(msg.sender, _spender, _value);        return true;    }    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {      return allowed[_owner][_spender];    }    mapping (address => uint256) balances;    mapping (address => mapping (address => uint256)) allowed;    uint256 public totalSupply;}contract WorldGamingCoin is StandardToken,Ownable {     string public name;               uint256 public decimals;          string public symbol;             address owner;    address tokenwallet;    address etherwallet;    function changeetherwallet(address _newwallet) onlyOwner() public returns (address) {        etherwallet = _newwallet ;    Changeetherwallet(etherwallet,_newwallet);    return ( _newwallet) ;}    function WorldGamingCoin() public {        owner=msg.sender;        tokenwallet= 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c;        etherwallet= 0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db;        name = "WorldGamingCoin";        decimals = 8;                    symbol = "iWGC";                  totalSupply = 1000000000 * (10**decimals);                balances[tokenwallet] = totalSupply;               // Give the creator all initial tokens     }    function getOwner() constant public returns(address){        return(owner);    }        }    contract sendETHandtransferTokens is WorldGamingCoin {        int dummyVar;        mapping(address => uint256) balances;            uint256 public totalETH;        event FundTransfer(address user, uint amount, bool isContribution);       function () payable public {        uint amount = msg.value;        totalETH += amount;        etherwallet.transfer(amount);         FundTransfer(msg.sender, amount, true);    }    }