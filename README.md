# single_masternode_setup
Manual to setup masternode on Ubuntu 20.04 system VPS

Minimal settings for VPS :

- 1 core 
- 2 GB RAM
- 2 GB SWAP
- 40 GB HDD

</h>

Creating masternode on main wallet

If You use MiracleBox Wallet:

You can download it from : https://gemlink.org/miraclebox </br>

1. Create new t-address or use empty t-address - give him label the same as planed masternode alias - it will be easier to find mn rewards.
2. Transfer to this t-address in one part 20000 coin.
3. After this You need wait about 2 confirmations.
4. Next go to masternode setup on GemCore:
	- press button Get Private Key"
	- pres button "Generate Masternode Data"
	- You will see below mndata - check the box on the left , data will be automaticaly move to free fields
	- copy to clipboard mn prv key generated with transacrion ID and index, it will be necessary to vps script
	- in "Alias name" field write <alias name> - the same as You add for t-address label
	- in "VPS IP" - ip address Your VPS - where will be mn set 

	## DON'T start the masternode You need to run first script on vps.
	
---------------------------------------------------------------------------------------------------------------------

On VPS with Ubuntu 20.04 </br>

# You need to be as a root user to run this script.

changing user on root on Ubuntu

```
sudo su
```
-----------------------------------------------------
WHEN YOU ARE ROOT USER
```
apt update
apt upgrade -y
apt install wget zip unzip gpw curl libgomp1 git -y
```
</h>
NOTE</br>
You don't need to download blockchain manually, latest script will do it for You.</br>
</h>
Download setup file</br>

```
cd
git clone https://github.com/gemlink/masternode_setup
cd masternode_setup
chmod +x ./part1.sh ./part2.sh
```
Check and create Swap

Run the following commands:
```
./part1.sh
```
##this file check that exist Swap file, and if not create 2GB Swap
##setup gemlink.service

------------------------------------------------------------

Befor run part2.sh You need to know :

1.Your vps ip</br>
2.Your masternode privatekey copied from GemCore</br>
	
	
<b>This is example </br>
	
Your vps ip is 193.25.2.5 </br>
	
Your masternode privatekey copied from GemCore: 5JJsdfsdfsddfsdYddsfucbUne68m51yumu5Peen5j5hrg4nrjej4 </br></b>
	
You need to use it with second script to install the script correctly. In next line add Your server data and masternode prv key !!! </br>
```
   ./part2.sh 193.25.2.5 5JJsdfsdfsddfsdYddsfucbUne68m51yumu5Peen5j5hrg4nrjej4
```
-this script will download all necessary data, install it, and will run gemlinkd  </br> 
	
It's very important to read the message below the installation process before starting masternode on Gemcore!!!!!. </br>
	
-----------------------------------------------------------------------------------------------------------------------
                       READ THIS CAREFULLY                                                                           
           YOU NEED TO WAIT FOR THE NODE TO BE SYNCED.                                                               
                                                                                                                     
  Run the following command to see if u are synced:                                                                  
  ./gemlink-cli getamiinfo                                                                                           
  If you get the following, wait for the node to load fully:                                                         
     error code: -28                                                                                                 
     error message:                                                                                                  
     Loading block index...                                                                                          
  Run the command again after a while.                                                                               
  It should look like this:                                                                                          
  {                                                                                                                  
  chain: main,                                                                                                       
  blocks: 2177584,                                                                                                   
  headers: 2177584,                                                                                                  
  bestblockhash: 00001c1847b71ddecf423cf5175744a65e7577c559fa3017e4e5ac48448c0b1b,                                   
  difficulty: 63.85400174980958,                                                                                     
  verificationprogress": 0.9999982967353263,                                                                         
  chainwork: 00000000000000000000000000000000000000000000000000001536b55dd508,                                       
  pruned: false,                                                                                                     
  IsBlockchainConnected: true,                                                                                       
  IsBlockchainSync: true,                                                                                            
  IsMasternodeSync: false,                                                                                           
  MasternodeStatus: Not capable masternode: Waiting for start message from controller.,                              
  info: https://github.com/apps-alis-is/glink.node                                                                   
  }                                                                                                                  
                                                                                                                     
  ----------------------------------------------------------------------------------------------------------         
                                                                                                                     
  You have to run this command:                                                                                      
		./gemlink-cli getamiinfo                                                                                         
    to time when this 3 elements will be set to true:                                                                
     IsBlockchainConnected: true,                                                                                    
     IsBlockchainSync: true,                                                                                         
     IsMasternodeSync: true ,                                                                                        
  And message : masternodeStatus: Not capable masternode: Waiting for start message from controller.                 
                                                                                                                     
   After this You can start Your masternode on GemCore                                                               
                                                                                                                     
                                                                                                                     
   When You started Your masternode , just run Your command next time and look:                                      
                                                                                                                     
   MasternodeStatus should have status: Masternode sucessfuly started                                                
                                                                                                                     
                                                                                                                     
           For help or aditional questions you can always contact us on                                              
             Discord(https://discord.com/invite/GghXuUnYmU)                                                          
-----------------------------------------------------------------------------------------------------------------------
	





