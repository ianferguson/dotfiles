#!/bin/bash

set -e

cd /tmp
git clone git://git.sv.gnu.org/screen.git
cd screen/src

mkdir -p /opt/etc
mv etc/etcscreenrc /opt/etc/screenrc

./autogen.sh
./configure --prefix=/usr/bin/local/Cellar/screen/4.1.dev  --enable-colors256 --with-sys-screenrc=/opt/etc/screenrc

make
make install
brew link screen

cd /tmp 
rm -rf screen

echo "Screen is at: `which screen`"
screen -v
