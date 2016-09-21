#!/usr/bin/env bash

wget http://downloads.raspberrypi.org/raspbian/images/raspbian-2016-05-31/2016-05-27-raspbian-jessie.zip
unzip 2016-05-27-raspbian-jessie.zip
mv 2016-05-27-raspbian-jessie-cross-compile-qt.img
sudo mkdir /mnt/rasp-pi-rootfs
sudo mount -o loop,offset=70254592 2016-05-27-raspbian-jessie-cross-compile-qt.img /mnt/rasp-pi-rootfs

wget http://calgarysolarcarteamhub.com/attachments/download/146/gcc-4.7-linaro-rpi-gnueabihf.tbz
tar -xf gcc-4.7-linaro-rpi-gnueabihf.tbz
sudo mv gcc-4.7-linaro-rpi-gnueabihf /opt/
sudo apt-get install ia32-libs

git clone https://git.milosolutions.com/other/cross-compile-tools.git
(cd cross-compile-tools && sudo chmod +x fixQualifiedLibraryPaths)
(cd cross-compile-tools && sudo ./fixQualifiedLibraryPaths /mnt/rasp-pi-rootfs/ /opt/gcc-4.7-linaro-rpi-gnueabihf/bin/arm-linux-gnueabihf-gcc)

git clone git://code.qt.io/qt/qt5.git
(cd qt5 && git checkout 5.5)
(cd qt5 && sed -i 's/git:/https:git./' .gitmodules)
(cd qt5 && ./init-repository -f)
(cd qt5 && git checkout v5.5.1)
(cd qt5 && ./configure -opengl es2 -device linux-rasp-pi-g++ -device-option CROSS_COMPILE=/opt/gcc-4.7-linaro-rpi-gnueabihf/bin/arm-linux-gnueabihf- -sysroot /mnt/rasp-pi-rootfs -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/qt5pi -hostprefix /usr/local/qt5pi -system-xcb)
(cd qt5 && make -j8 && sudo make install)

(cd qt5/qtserialport && /usr/local/qt5pi/bin/qmake)
(cd qt5/qtserialport && make -j8 && sudo make install)
