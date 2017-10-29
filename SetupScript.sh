#!/bin/bash

sudo: required
###base script to fresh install systems onto base image for raspberry pi

#configure displays
cd ~
git clone https://github.com/UCSolarCarTeam/Epsilon-Raspberry.git
cd Epsilon-Raspberry/primary/
cp xorg.conf /etc/X11/
cp config.txt /boot/
#install rabbit-mq

echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list && sudo apt-get update && sudo apt-get install rabbitmq-server
sudo apt-get install cmake libboost-dev openssl libssl-dev libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev software-properties-common build-essential mesa-common-dev libgl1-mesa-dev

cd /tmp/
if ls /usr/local/lib/librabbitmq.* 1> /dev/null 2>&1 ;
then
echo "Rabbitmq already setup"
else
git clone https://github.com/alanxz/rabbitmq-c
mkdir rabbitmq-c/build && cd rabbitmq-c/build
cmake ..
cmake --build .
cp librabbitmq/*.a /usr/local/lib/
cp librabbitmq/*.so* /usr/local/lib/
fi

#begin QT install
apt-get update
yes | apt-get upgrade
 