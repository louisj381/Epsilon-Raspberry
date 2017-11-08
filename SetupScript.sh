#!/bin/bash

sudo: required
#base script to fresh install systems onto base image for raspberry pi

#configure displays
cd /opt/
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
apt-get --yes upgrade
apt-get install --yes libfontconfig1-dev libdbus-1-dev libfreetype6-dev libudev-dev libicu-dev libsqlite3-dev
libxslt1-dev libssl-dev libasound2-dev libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev
libgstreamer-plugins-base0.10-dev gstreamer-tools gstreamer0.10-plugins-good gstreamer0.10-plugins-bad
libraspberrypi-dev libpulse-dev libx11-dev libglib2.0-dev libcups2-dev freetds-dev libsqlite0-dev libpq-dev
libiodbc2-dev libmysqlclient-dev firebird-dev libpng12-dev libjpeg9-dev libgst-dev libxext-dev libxcb1 libxcb1-dev
libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0
libxcb-shm0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-sync1 libxcb-sync-dev libxcb-render-util0
libxcb-render-util0-dev libxcb-xfixes0-dev libxrender-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-glx0-dev
libxi-dev libdrm-dev libssl-dev libxcb-xinerama0 libxcb-xinerama0-dev

mkdir ~/opt
cd ~/opt
git clone git://code.qt.io/qt/qt5.git
cd qt5
./init-repository

