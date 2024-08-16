#!/bin/bash
# This script helps configure network settings

if ! dpkg -l | grep -q "^ii.*wget" ; then sudo apt-get update -qq && sudo apt-get install wget -y && sleep 1 ; fi
bash <(wget -qO- https://raw.githubusercontent.com/chenh19/network_cofig/main/src/home-wifi.sh)
bash <(wget -qO- https://raw.githubusercontent.com/chenh19/network_cofig/main/src/mobile-wwan.sh)
bash <(wget -qO- https://raw.githubusercontent.com/chenh19/network_cofig/main/src/mobile-hotspot.sh)
bash <(wget -qO- https://raw.githubusercontent.com/chenh19/network_cofig/main/src/university-wifi.sh)
bash <(wget -qO- https://raw.githubusercontent.com/chenh19/network_cofig/main/src/university-vpn.sh)
