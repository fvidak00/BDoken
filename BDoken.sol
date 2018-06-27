pragma solidity ^0.4.23;

contract Owned
{
    address public owner;

    constructor() public
    {
        owner = msg.sender;
    }

    modifier onlyOwner 
    {
        require(msg.sender == owner);
        _;
    }

    function TransferOwnership(address newOwner) onlyOwner public
    {
        owner = newOwner;
    }
}

contract BDoken is Owned
{
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;

    event TransferEvent (address indexed from, address indexed to, uint256 value);

    uint256 public sellPrice;
    uint256 public buyPrice;

    /// @param initialSupply In ETH, not Wei
    /// @param centralMinter "Optional"
    constructor(uint256 initialSupply, string tokenName, string tokenSymbol, address centralMinter, uint256 sellPr, uint256 buyPr) public
    {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply / 2;
        balanceOf[this] = totalSupply / 2;
        name = tokenName;
        symbol = tokenSymbol;
        if(centralMinter != 0)
            owner = centralMinter;
        sellPrice = sellPr;
        buyPrice = buyPr;
    }

    function PayUp(address _to, uint256 _value) public returns (bool success)
    {
        return Transfer(msg.sender, _to, _value);
    }
    
    function Transfer(address _from, address _to, uint256 _value) public returns (bool success)
    {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit TransferEvent(_from, _to, _value);

        return true;
    }

    function MintToken(address target, uint256 mintedAmount) onlyOwner public
    {
        balanceOf[target] += mintedAmount;
        totalSupply += mintedAmount;
        emit TransferEvent(0, owner, mintedAmount);
        emit TransferEvent(owner, target, mintedAmount);
    }

    function CheckBalance() public view returns (uint256 balance)
    {
        return balanceOf[msg.sender];
    }

    function CheckRequiredFunds(uint256 _value) public view returns (bool enough)
    {
        require(balanceOf[msg.sender] >= _value);
        return true;
    }

    /// @param newSellPrice Sets modifier used in sell(), you sell BD to contract, it gives amount*sellPrice back, inWei
    /// @param newBuyPrice Sets modifier used in buy(),  inWei
    function SetPrices(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner public
    {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }

    /// @notice msg.value How much your ETH (not WEI) you want to exchange for BD, BD = ETH*(buyPriceInBD)
    /// @notice Contract gets ETH, caller gets BD
    function Buy() payable public
    {
        uint256 amount = msg.value * buyPrice / (10 ** uint256(decimals));
        require(balanceOf[this] >= amount);
        Transfer(this, msg.sender, amount);
    }

    /// @param amount How much BD in Wei you give to contract, gives you ETH=amount/sellPrice
    /// @notice Contract gets BD in Wei, caller gets ETH
    function Sell(uint256 amount) public
    {
        require(balanceOf[msg.sender] >= amount);
        uint256 revenue = amount / sellPrice;
        Transfer(msg.sender, this, amount);
        msg.sender.transfer(revenue);
    }

    function BloodForTheBloodGod() payable public returns (bool success)
    {
        return true;
    }

    function GetSellPrice() public view returns(uint256 price)
    {
        return sellPrice;
    }

    function GetBuyPrice() public view returns(uint256 price)
    {
        return buyPrice;
    }
}