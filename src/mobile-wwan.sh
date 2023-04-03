#!/bin/bash
#This script helps config mobile wwan settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'


# mobile wwan
sudo echo ""
read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to config Mobile WWAN connections? [y/n/c]'$TEXT_RESET)"$' \n' choice
case "$choice" in
  y|Y ) # notify start
        sudo echo ""
        echo -e "${TEXT_YELLOW}Installing WWAN (Modem Manager)...${TEXT_RESET} \n" && sleep 1

        # install mobile wwan
        sudo apt-get update && sudo apt-get install modem-manager-gui -y
        [ ! -d ~/.config/modem-manager-gui/ ] && mkdir ~/.config/modem-manager-gui/
        kwriteconfig5 --file ~/.config/modem-manager-gui/settings.conf --group settings --key behaviour_ask_to_hide "false"
        kwriteconfig5 --file ~/.config/modem-manager-gui/settings.conf --group settings --key behaviour_hide_to_tray "true"
        kwriteconfig5 --file ~/.config/modem-manager-gui/settings.conf --group settings --key window_hide_notify_shown "true"
        kwriteconfig5 --file ~/.config/modem-manager-gui/settings.conf --group settings --key behaviour_ask_to_hide "false"
        
        # connect now
        sudo echo ""
        read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to connect to WWAN network now [y/n/c]?'$TEXT_RESET)"$' \n' choice
        case "$choice" in
              y|Y ) echo -e " \n${TEXT_YELLOW}Please config WWAN connection and quit WWAN (from system tray) to continue.${TEXT_RESET} \n" && sleep 1
                    modem-manager-gui;;
              * )   ;;
        esac
        
        # notify end
        echo -e " \n${TEXT_GREEN}Mobile WWAN configuration finished!${TEXT_RESET} \n" && sleep 1;;
        
  * )   # notify cancellation
        echo -e " \n${TEXT_YELLOW}Mobile WWAN configuration skipped.${TEXT_RESET} \n" && sleep 1;;
esac
