#!/usr/bin/env bash

set -e

#
# ImageMagick install bash script
#
# Compile and install ImageMagick with Ghostscripts libs from source.
# Source is downloaded and unzipped at /usr/local/src.
#
# Usage:
#
# sudo chmod ug=rwx ./install.sh
# sudo ./install.sh
#

echo "
#
# ImageMagick install bash script
#
"

while true; do
    read -p "The next steps could take some time and and active internet connection is required, continue? (y/n) " yn
    case $yn in
        [Yy]* ) echo "contnue.."; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes [Yy] or no [Nn].";;
    esac
done

SRC_DIR=/usr/local/src

IM=ImageMagick
IM_VERSION=6.9.1-4
IM_TAR_URL=http://www.imagemagick.org/download/${IM}.tar.gz
IM_TAR=${SRC_DIR}/${IM}.tar.gz
IM_UNTAR_DIR=${SRC_DIR}/${IM}-${IM_VERSION}

# install deps with apt-get
sudo apt-get install wget -y;
sudo apt-get install ghostscript -y;
sudo apt-get install libgs-dev -y;

# remove apt imagemagick
sudo apt-get --purge remove imagemagick;

# clean previous
sudo rm -rf ${IM_TAR}
sudo rm -rf ${IM_UNTAR_DIR};

# download latest source at /usr/local/src
sudo wget ${IM_TAR_URL} -P ${SRC_DIR}
sudo tar -xvf ${IM_TAR} -C ${SRC_DIR};

# configure and make
cd ${IM_UNTAR_DIR}
sudo ./configure --with-gslib=yes
sudo make && sudo make install

# return in the current folder
cd - 1> /dev/null

# convert version
/usr/local/bin/convert --version

echo "DONE!"
exit 0
