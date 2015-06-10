#!/usr/bin/env bash

IM=ImageMagick
SRC_DIR=/usr/local/src
IM_DOWNLOAD_URL=http://www.imagemagick.org/download/${IM}.tar.gz
IM_TAR_PATH=${SRC_DIR}/${IM}.tar.gz
IM_LATEST_VERSION=6.9.1-4
IM_UNCOMPRESSED_DIR=${SRC_DIR}/${IM}-${IM_LATEST_VERSION}

# install deps with apt-get
sudo apt-get install wget -y;
sudo apt-get install ghostscript -y;
sudo apt-get install libgs-dev -y;

# remove apt imagemagick
sudo apt-get --purge remove imagemagick;

# clean previous
sudo rm -rf ${IM_TAR_PATH}
sudo rm -rf ${IM_UNCOMPRESSED_DIR};

# download latest source in /usr/local/src
sudo wget ${IM_DOWNLOAD_URL} -P ${SRC_DIR}
sudo tar -xvf ${IM_TAR_PATH} -C ${SRC_DIR};

# configure and make
cd ${IM_UNCOMPRESSED_DIR} && pwd
sudo ./configure --with-gslib=yes
sudo make && make install

# return in the current folder
cd - 1> /dev/null

# convert version
/usr/local/bin/convert --version

exit 0
