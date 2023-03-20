#!/bin/bash
#This script helps config home wifi settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'


# home wifi
sudo echo ""
read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to configure Home WiFi connections? [y/n/c]'$TEXT_RESET)"$' \n' choice
case "$choice" in
    y|Y ) nmtui
          echo -e " \n${TEXT_GREEN}Home WiFi configuration finished!${TEXT_RESET} \n" && sleep 1;;
    * )   echo -e " \n${TEXT_YELLOW}Home WiFi configuration skipped.${TEXT_RESET} \n" && sleep 1;;
esac
