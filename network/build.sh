#!/bin/bash
#
# Exit on first error, print all commands.
set -e

IMAGETAG="1.4.1"
COMPOSE_PROJECT_NAME="network"

#Start from here
echo -e "\nStopping the previous network (if any)"
IMAGE_TAG=$IMAGETAG COMPOSE_PROJECT_NAME=$COMPOSE_PROJECT_NAME docker-compose -f docker-compose.yml down

# If need to re-generate the artifacts, uncomment the following lines and run
#
# cryptogen generate --config=./crypto-config.yaml
# mkdir config
# configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./config/genesis.block
# configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./config/channel.tx -channelID mychannel
# configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
# configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
#
# Create and Start the Docker containers for the network
echo -e "\nSetting up Hyperledger Fabric network ($IMAGETAG)"
IMAGE_TAG=$IMAGETAG COMPOSE_PROJECT_NAME=$COMPOSE_PROJECT_NAME docker-compose -f docker-compose.yml up -d
sleep 15
echo -e "\nNetwork setup completed!!\n"
