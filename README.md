# ImageMagick install bash script

Compile and install ImageMagick with Ghostscripts libs from source.
Source is downloaded and unzipped at /usr/local/src.

Tested on:
    * Linux Ubuntu 14.04.2 Trusty LTS 
    * Travis-CI [![Build Status](https://travis-ci.org/rbarilani/imagemagick-ubuntu-install.svg)](https://travis-ci.org/rbarilani/imagemagick-ubuntu-install)

## Usage:

```
bash -c "$(wget -O - https://raw.githubusercontent.com/rbarilani/imagemagick-ubuntu-install/master/install.sh)"
```

or clone the repository and then run the install script:

```
git clone https://github.com/rbarilani/imagemagick-ubuntu-install.git
cd imagemagick-ubuntu-install
chmod +x ./install.sh
./install.sh
```
