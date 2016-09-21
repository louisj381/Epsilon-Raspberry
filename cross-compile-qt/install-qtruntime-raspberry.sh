#!/usr/bin/env bash

wget http://calgarysolarcarteamhub.com/attachments/download/145/qt5pi.tar.gz
tar -zxvf qt5pi.tar.gz
rm qt5pi.tar.gz
mv qt5pi /usr/local

echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/qt5pi/lib/" >> ~/.bashrc
