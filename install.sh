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

echo_help() {
    echo "
Usage:

./install.sh [-y|--yes] [-h|--help]

Options:

* -y or --yes  : don't ask confirmation
* -h or --help : print this help
"
}

SRC_DIR=/usr/local/src
YES=false
ARGS=[]

IM=ImageMagick
IM_VERSION=6.9.1-4
IM_TAR_URL=http://www.imagemagick.org/download/${IM}.tar.gz
IM_TAR=${SRC_DIR}/${IM}.tar.gz
IM_UNTAR_DIR=${SRC_DIR}/${IM}-${IM_VERSION}
IM_CONVERT_BIN=/usr/local/bin/convert
#
# PARSE OPTIONS AND ARGUMENTS
#
for i in "$@"
do
case $i in
    -y|--yes)
    YES=true
    shift # past argument=value
    ;;
    -h|--help)
    echo_help; shift; exit 0;
    break;;
    *)
    if ! [[ ${i} =~ ^--* ]]; then
        ARGS+=(${i})
    else
        echo_help; echo "Unknown option '${i}'"; exit 1;
    fi;
    ;;
esac
done

if [ ${YES} != true ]; then
    while true; do
        read -p "The next steps could take some time and and active internet connection is required, continue? (y/n) " yn
        case $yn in
            [Yy]* ) echo "contnue.."; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes [Yy] or no [Nn].";;
        esac
    done
fi

# install deps with apt-get
sudo apt-get update;
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

# HOTFIX? https://gist.github.com/wacko/39ab8c47cbcc0c69ecfb
#
# if you get this error when /usr/local/bin/convert:
#   convert: error while loading shared libraries: libMagickCore-6.Q16.so.2: cannot open shared object file: No such file or directory
# run this command:
#   sudo ldconfig /usr/local/lib
#
sudo ldconfig /usr/local/lib

# convert version
${IM_CONVERT_BIN} --version

echo "DONE!"
exit 0
