#!/bin/sh -

#Functions
command_exists () {
    type "$1" &> /dev/null ;
}

#Install Docker
if command_exists docker ; then
    echo "Docker Exists"
else
  echo "Docker does not exist. Installing docker..."
  uname -r
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo touch /etc/apt/sources.list.d/docker.list
  sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee  /etc/apt/sources.list.d/docker.list
  sudo apt-get update
  sudo apt-get --assume-yes purge lxc-docker
  sudo apt-cache policy docker-engine
  sudo apt-get update
  sudo apt-get --assume-yes install linux-image-extra-$(uname -r)
  sudo apt-get --assume-yes install docker-engine
fi

sudo service docker start

#Install Docker Compose. 
if which docker-compose </dev/null; then
  sudo apt-get -y install python-pip
  sudo pip install docker-compose
fi
#Clone CloudBoost docker repo. 
if which git </dev/null; then
  sudo apt-get -y install git
fi
git clone https://github.com/CloudBoost/docker.git
cd docker

#Run Docker compose. 
sudo docker-compose up -d



