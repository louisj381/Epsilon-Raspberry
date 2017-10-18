#!/bin/bash

###base script to fresh install systems onto base image for raspberry pi

#configure displays
cd ~
git clone https://github.com/UCSolarCarTeam/Epsilon-Raspberry.git
cd Epsilon-Raspberry
cd primary/
sudo cp xorg.conf /etc/X11/
sudo cp config.txt /boot/
#install rabbit-mq
cd ~
git clone https://github.com/UCSolarCarTeam/Epsilon-Dashboard.git
cd Epsilon-Dashboard/
yes | ./EpsilonDashboardSetup.sh #continue through without inturruption

