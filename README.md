Made for professional practice required by university in the length of 300 hours

Project:

    Video hosting service
    Content uploaded by users who set the price per view in project's custom cryptocurrency
    Custom cryptocurrency exchangeable with other cryptocurrencies
    Viewers pay the set price in custom cryptocurrency each time they watch a video

Technology requirements:

    ASP.NET
    C#.NET
    AngularJS
    Cryptocurrency:
      Ethereum-based ERC20 token
    Database:
      Microsoft SQL Server 2018

Professional practice was split in 2 parts, basic draft and final version:

    Basic draft: https://github.com/fvidak00/Bdots1
    Final version: https://github.com/fvidak00/BDhub
    Custom cryptocurreny and testnet: https://github.com/fvidak00/BDoken




For future self:

All required files for setting up a Ethereum testnet with custom ERC20 token contract.

Get geth.exe from here: https://geth.ethereum.org/downloads/

Start CMD, navigate to where geth.exe is or use <i>folderInWhichGethExeIs/geth</i> instead geth.

1) Change <i>path</i> to wherever genesis (BDGene.json in this case) file is.

geth --datadir <i>path</i> init <i>genesis file</i>

2) --networkid can be any number (I think it is any, sticked with 5 digits for reasons I can't remember), e.g. 54652
3) --identity is string, e.g. "BeternumNetwork".
4) --rpcaddr is IP address of PC where testnet is running, e.g. "192.168.21.104".
5) --rpcport is port at which you want to connect, e.g. "52353"

geth --datadir <i>path</i> --networkid <i>ID[integer]</i> --identity <i>"string"</i> --rpc --rpcaddr <i>"IP address"</i> --rpcport <i>"port"</i> --rpccorsdomain "*" --rpcapi "eth,web3,personal,admin,mine,net" --verbosity 2 --nodiscover --maxpeers 8 console

6) Creates new account, need one in order to start mining the chain.

personal.NewAccount()

7) Start mining
geth --datadir <i>path</i> --networkid <i>ID[integer]</i> --identity <i>"string"</i> --rpc --rpcaddr <i>"IP address"</i> --rpcport <i>"port"</i> --rpccorsdomain "*" --rpcapi "eth,web3,personal,admin,mine,net" --mine -verbosity 3 --nodiscover --maxpeers 8 miner

8) If you want to write commands in, open new CMD (where geth is, know the drill) and write:

geth --datadir <i>path</i> --networkid <i>ID[integer]</i> --identity <i>"string"</i> --rpc --rpcaddr <i>"IP address"</i> --rpcport <i>"port"</i> --rpccorsdomain "*" --rpcapi "eth,web3,personal,admin,mine,net" --verbosity 2 --nodiscover --maxpeers 8 attach <i>http://IPaddress:port</i> console

<i>http://IPaddress:port</i> e.g. http://192.168.21.104:52353

9) Get Ethereum Wallet and Google the rest.
