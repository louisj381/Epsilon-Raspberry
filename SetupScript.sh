#!/bin/bash

###base script to fresh install systems onto base image for raspberry pi

#configure displays
cd ~
git clone https://github.com/UCSolarCarTeam/Epsilon-Raspberry.git
cd Epsilon-Raspberry/primary
sudo cp xorg.conf /etc/X11/
sudo cp config.txt /boot/