# set the hostname in /etc/hosts
sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

echo "============================Install Docker==============================="
# as per documentations of docker
# make sure apt works with http
cd

sudo apt-get update

sudo apt-get -y install bridge-utils

sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cd
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > docker.list
sudo mv ./docker.list /etc/apt/sources.list.d/

sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine

sudo apt-get update
sudo apt-get install -y docker-engine
sudo service docker start


echo "=========================Create bridge==================================="
##create bridge to avoid conflict with ip

sudo service docker stop
sudo ip link set dev docker0 down
sudo brctl delbr docker0
sudo iptables -t nat -F POSTROUTING
sudo brctl addbr bridge0
sudo ip addr add 192.168.5.1/24 dev bridge0
sudo ip link set dev bridge0 up
echo 'DOCKER_OPTS="-b=bridge0"' > docker
sudo mv ./docker /etc/default/
sudo service docker start
sudo iptables -t nat -L -n

echo "==========================Add username to docker group=================================="
sudo groupadd docker
sudo gpasswd -a ${USER} docker

echo "==========================Clean up======================================="
# Clean-up
cd
rm SetUpDocker.sh

echo "=========================Pull Docker Image======================"
# this is because we want to be able to update the user's group association witout
# having to log out or without creating a sub-shell which is what newgrp does.
sudo sg docker -c "docker pull sahandha/ubuntu"
