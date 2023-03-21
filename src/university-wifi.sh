#!/bin/bash
#This script helps config university wifi settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'


# university wifi
sudo echo ""
read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to configure University WiFi connections? [y/n/c]'$TEXT_RESET)"$' \n' choice
case "$choice" in
    y|Y ) # notify start
          sudo echo ""
          echo -e "${TEXT_YELLOW}Installing University WiFi (SecureW2)...${TEXT_RESET} \n" && sleep 1
          
          # download scripts
          [ ! -d /opt/icon/ ] && sudo mkdir /opt/icon/
          [ ! -d /opt/eduroam/ ] && sudo mkdir /opt/eduroam/
          [ ! -d /opt/eduroam/SecureW2/ ] && sudo mkdir /opt/eduroam/SecureW2/
          [ ! -f SecureW2 ] && wget -q https://www.dropbox.com/s/jp2v4or1kavwiwq/SecureW2.zip?dl=0 -O SecureW2.zip && sleep 1
          unzip -o -q SecureW2.zip && sleep 1 && rm -f SecureW2.zip
          sudo cp -f ./SecureW2/securew2.png /opt/icon/securew2.png
          sudo cp -f ./SecureW2/run.sh /opt/eduroam/SecureW2/run.sh
          
          # make shortcut
          [ ! -f /usr/share/applications/securew2.desktop ] && sudo touch /usr/share/applications/securew2.desktop
          sudo desktop-file-edit \
              --set-name 'University WiFi' --set-key 'Name[en_US]' --set-value 'University WiFi' --set-key 'Name[zh_CN]' --set-value '校园网WiFi' \
              --set-generic-name 'SecureW2 Eduroam' --set-key 'GenericName[en_US]' --set-value 'SecureW2 Eduroam' --set-key 'GenericName[zh_CN]' --set-value 'Eduroam高校网络' \
              --set-comment 'Secure world-wide roaming wireless service for universities' --set-key 'Comment[en_US]' --set-value 'Secure world-wide roaming wireless service for universities' --set-key 'Comment[zh_CN]' --set-value '安全的全球高校无线网络漫游服务' \
              --set-key 'Exec' --set-value 'bash /opt/eduroam/SecureW2/run.sh' \
              --set-icon '/opt/icon/securew2.png' \
              --set-key 'NoDisplay' --set-value 'false' \
              --set-key 'Terminal' --set-value 'true' \
              --set-key 'TerminalOptions' --set-value '' \
              --set-key 'Type' --set-value 'Application' \
              --remove-key 'Categories' --add-category 'Network;' \
          /usr/share/applications/securew2.desktop
          
          # select university
          sudo echo ""
          read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Which University are you at, UChicago (a) or UIUC (b)?'$TEXT_RESET)"$' \n' choice
          case "$choice" in
                b|B ) sudo cp -f ./SecureW2/UIUC_WiFi.run /opt/eduroam/SecureW2/university-wifi.run
                      echo -e " \n${TEXT_GREEN}UIUC eduroam has been selected!${TEXT_RESET} \n" && sleep 1;;
                * )   sudo cp -f ./SecureW2/UChicago_WiFi.run /opt/eduroam/SecureW2/university-wifi.run
                      echo -e " \n${TEXT_GREEN}UChicago eduroam has been selected!${TEXT_RESET} \n" && sleep 1;;
          esac
          rm -rf ./SecureW2/
          
          # connect now
          sudo echo ""
          read -n1 -s -r -p "$(echo -e $TEXT_YELLOW'Would you like to connect to University WiFi now [y/n/c]?'$TEXT_RESET)"$' \n' choice
          case "$choice" in
                y|Y ) bash /opt/eduroam/SecureW2/run.sh;;
                * )   ;;
          esac
          
          # notify end
          echo -e " \n${TEXT_GREEN}University WiFi configuration finished!${TEXT_RESET} \n" && sleep 1;;
          
    * )   # notify cancellation
          echo -e " \n${TEXT_YELLOW}University WiFi configuration skipped.${TEXT_RESET} \n" && sleep 1;;
esac
