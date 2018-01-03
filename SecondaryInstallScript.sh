#!/bin/bash

if [ $USER -ne "root"]
 	then
 	echo "Permission Denied"
 	exit 1
fi

ping -q -c1 google.com > /dev/null
 
if [ $? -ne 0 ]
then
	echo "No Internet Connection...Aborting"
	exit 1
fi

#install Epsilon-Onboard-Media-Control
(cd /usr/local && git clone https://github.com/UCSolarCarTeam/BackupCamera.git)
cd /usr/local/BackupCamera/Installer
./MainInstaller.sh
./AutoBootSetup.sh
tvservice -d edid 
edidparser edid

#install Dashboard
(cd /usr/local && git clone https://github.com/UCSolarCarTeam/Epsilon-Dashboard.git)
cd /usr/local/Epsilon-Dashboard
./EpsilonDashboardSetup.sh

#install music-player
cd /usr/local
git clone https://github.com/UCSolarCarTeam/Epsilon-Onboard-Media-Control.git

#install Domovoi
cd /usr/local
git clone https://github.com/UCSolarCarTeam/Epsilon-Domovoi.git
