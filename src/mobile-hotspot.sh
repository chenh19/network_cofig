#!/bin/bash
#This script helps config wifi hotspot settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'


# wifi hotspot
sudo echo ""
read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to config WiFi Hotspot? [y/n/c]'$TEXT_RESET)"$' \n' choice
case "$choice" in
  y|Y ) # notify start
        sudo echo ""
        echo -e "${TEXT_YELLOW}Installing WiFi Hotspot...${TEXT_RESET} \n" && sleep 1

        # install WiFi Hotspot
        sudo add-apt-repository ppa:lakinduakash/lwh -y
        sudo apt-get update && sudo apt-get install linux-wifi-hotspot -y
        
        # connect now
        sudo echo ""
        read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to configure WiFi Hotspot now [y/n/c]?'$TEXT_RESET)"$' \n' choice
        case "$choice" in
              y|Y ) echo -e " \n${TEXT_YELLOW}Please configure and then close WiFi Hotspot to continue.${TEXT_RESET} \n" && sleep 1
                    wihotspot;;
              * )   ;;
        esac
        
        # notify end
        echo -e " \n${TEXT_GREEN}WiFi Hotspot configuration finished!${TEXT_RESET} \n" && sleep 1;;
        
  * )   # notify cancellation
        echo -e " \n${TEXT_YELLOW}WiFi Hotspot configuration skipped.${TEXT_RESET} \n" && sleep 1;;
esac
