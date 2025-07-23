#!/bin/bash

# Args: $1    $2    
#       ip    key
# example: ./part2.sh mn1 207.145.65.77 5JJaWW...4nrjej4

rpcuser=$(gpw 1 30)
rpcpassword=$(gpw 1 30)

killall -9 gemlinkd > /dev/null 2>&1

# Setup ~/.gemlink/gemlink.conf

cd
if [ ! -d ~/.gemlink ]; then
  mkdir .gemlink
fi

echo "Creating gemlink.conf file..."

echo "rpcuser=$rpcuser
rpcpassword=$rpcpassword
addnode=explorer.gemlink.org
addnode=dnsseed1.gemlink.org
addnode=dnsseed2.gemlink.org
addnode=dnsseed3.gemlink.org
txindex=1
server=1
listen=1
port=16113
rpcport=16112
" > ~/.gemlink/gemlink.conf 

if echo $1 | grep ":16113" ; then
  echo "masternodeaddr=$1
externalip=$1" >> ~/.gemlink/gemlink.conf
else
  echo "masternodeaddr=$1:16113
externalip=$1:16113" >> ~/.gemlink/gemlink.conf
fi

echo "masternode=1
masternodeprivkey=$2" >> ~/.gemlink/gemlink.conf

# Download and install params
wget -N https://bc.gemlink.org/download/zcash-params.zip
unzip -o ./zcash-params.zip -d ~
rm ./zcash-params.zip

# Download and unzip binary
wget -N https://github.com/gemlink/gemlink/releases/download/v4.3.1/gemlink-ubuntu-4.3.1.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~
rm ./binary.zip

# Download and unzip latest bootstrap
if [ ! -d ~/.gemlink/blocks ] ; then
  wget -N https://bc.gemlink.org/download/bc.zip 
  unzip -o ~/bc.zip -d ~/.gemlink
  rm ~/bc.zip
fi

chmod +x ~/gemlinkd ~/gemlink-cli

# Enable and start tent.service
systemctl enable --now gemlink.service

echo "
#######################################################################################################################
#                       READ THIS CAREFULLY                                                                           #
#           YOU NEED TO WAIT FOR THE NODE TO BE SYNCED.                                                               #
#                                                                                                                     #
#  Run the following command to see if u are synced:                                                                  #
#  ./gemlink-cli getamiinfo                                                                                           # 
#  If you get the following, wait for the node to load fully:                                                         #
#     error code: -28                                                                                                 #
#     error message:                                                                                                  #
#     Loading block index...                                                                                          #
#  Run the command again after a while.                                                                               #
#  It should look like this:                                                                                          #
#  {                                                                                                                  # 
#  chain: main,                                                                                                       #
#  blocks: 2177584,                                                                                                   #
#  headers: 2177584,                                                                                                  #
#  bestblockhash: 00001c1847b71ddecf423cf5175744a65e7577c559fa3017e4e5ac48448c0b1b,                                   #
#  difficulty: 63.85400174980958,                                                                                     #
#  verificationprogress: 0.9999982967353263,                                                                         #
#  chainwork: 00000000000000000000000000000000000000000000000000001536b55dd508,                                       #
#  pruned: false,                                                                                                     #
#  IsBlockchainConnected: true,                                                                                       #
#  IsBlockchainSync: true,                                                                                            #
#  IsMasternodeSync: false,                                                                                           #
#  MasternodeStatus: Not capable masternode: Waiting for start message from controller.,                              #
#  info: https://github.com/apps-alis-is/glink.node                                                                   #
#  }                                                                                                                  #
#                                                                                                                     #
#  ----------------------------------------------------------------------------------------------------------         #
#                                                                                                                     #
#  You have to run this command to time when this 3 elements will be set to true:                                     #
#     IsBlockchainConnected: true,                                                                                    #
#     IsBlockchainSync: true,                                                                                         #
#     IsMasternodeSync: true ,                                                                                        #
#  And message : masternodeStatus: Not capable masternode: Waiting for start message from controller.                 #
#                                                                                                                     #
#   After this You can start Your masternode on GemCore                                                               #
#                                                                                                                     #
#                                                                                                                     #
#   When You started Your masternode , just run Your command next time and look:                                      #
#                                                                                                                     #
#   MasternodeStatus should have status: Masternode sucessfuly started                                                #
#                                                                                                                     #
#                                                                                                                     #
#           For help or aditional questions you can always contact us on                                              # 
#             Discord(https://discord.com/invite/GghXuUnYmU)                                                          #
#######################################################################################################################"
