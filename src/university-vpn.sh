#!/bin/bash
#This script helps config university vpn settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'


# university vpn
sudo echo ""
read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to config University VPN? [y/n/c]'$TEXT_RESET)"$' \n' choice
case "$choice" in
  y|Y ) # notify start
        sudo echo ""
        echo -e "${TEXT_YELLOW}Installing University VPN (Cisco Anyconnect)...${TEXT_RESET} \n" && sleep 1

        # install University VPN
        [ ! -f anyconnect.zip ] && wget -q https://www.dropbox.com/s/o4a5so0at8tev76/anyconnect.zip?dl=0 -O anyconnect.zip && echo '"Cisco Anyconnet client" deb package is downloaded.' && sleep 5 #_to_be_updated
        unzip -o -q anyconnect.zip -d ./anyconnect/ && sleep 1 && rm -f anyconnect.zip && sleep 1
        sudo apt-get install ./anyconnect/cisco-anyconnect*.deb -y && sleep 1 && rm -rf ./anyconnect/
        echo -e " \n${TEXT_YELLOW}Please connect to ${TEXT_GREEN}[vpn.uchicago.edu]${TEXT_YELLOW} or ${TEXT_GREEN}[vpn.illinois.edu]${TEXT_YELLOW} and disconnect, then close the VPN client to continue.${TEXT_RESET} \n" && sleep 1
        /opt/cisco/anyconnect/bin/vpnui

        # notify end
        echo -e " \n${TEXT_GREEN}University VPN configuration finished!${TEXT_RESET} \n" && sleep 5;;
  * )   # notify cancellation
        echo -e " \n${TEXT_YELLOW}University VPN configuration skipped.${TEXT_RESET} \n" && sleep 5;;
esac
