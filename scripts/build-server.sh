#!/bin/bash

export PATH=$PATH:/usr/bin

sudo apt-get update

sudo apt-get -y install make

sudo apt-get -y install docker.io

sudo apt-get -y install git

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo service docker restart

make -C /home -f deploy.mk start-init
