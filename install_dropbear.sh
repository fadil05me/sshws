#!/bin/bash
set -e  # Exit on error

sudo apt update && sudo apt install -y build-essential zlib1g-dev python2
wget -q --show-progress https://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2
tar xvjf dropbear-2019.78.tar.bz2 && cd dropbear-2019.78
./configure && make && sudo make install
sudo mkdir -p /etc/dropbear
sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
sudo nano /etc/systemd/system/dropbear.service
