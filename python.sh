#!/bin/bash

# Create necessary directories and files
mkdir -p /etc/xray /etc/v2ray
touch /etc/xray/domain /etc/v2ray/domain /etc/xray/scdomain /etc/v2ray/scdomain

# Update and install required packages
apt-get update
apt-get install -y software-properties-common build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git

# Download and install Python 2.7 from source
cd /usr/src
wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
tar xzf Python-2.7.18.tgz
cd Python-2.7.18
./configure --enable-optimizations
make altinstall

# Ensure python2.7 is the command for Python 2.7
update-alternatives --install /usr/bin/python python /usr/local/bin/python2.7 1
update-alternatives --set python /usr/local/bin/python2.7

# Check that 'python' command works and points to Python 2.7
if ! python --version 2>&1 | grep -q "Python 2.7"; then
    echo "Failed to set python to Python 2.7"
    exit 1
fi

echo "Python 2.7 has been installed and set as the default python command."
