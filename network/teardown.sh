#!/bin/bash
#
# Exit on first error, print all commands.
set -ev

IMAGETAG="1.4.1"
COMPOSE_PROJECT_NAME="network_byfn"

# Shut down the Docker containers for the system tests.
docker-compose -f docker-compose.yml down --volumes --remove-orphans
if [ "$(docker ps -aq)" ]; then
	docker rm -f $(docker ps -aq)
fi

# remove chaincode docker images
if [ "$(docker images dev-* -q)" ]; then
	docker rmi $(docker images dev-* -q)
fi

# Your system is now clean
