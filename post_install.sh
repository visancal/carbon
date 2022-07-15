#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Git" off   # any option can b
	         2 "VLC Media Player" off
	         3 "Google Chrome" off
	         4 "Teamiewer" off
	         5 "Skype" off
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in

			1)
				#Install git
				echo "Installing Git, please congiure git later..."
				apt install git -y
				;;

			2)
				#VLC Media Player
				echo "Installing VLC Media Player"
				apt install vlc -y
				;;
        
			3)
				#Chrome
				echo "Installing Google Chrome"
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
				apt-get update 
				apt-get install google-chrome-stable -y
				;;
			4)
				#Teamviewer
				echo "Installing Teamviewer"
				wget http://download.teamviewer.com/download/teamviewer_i386.deb
				dpkg -i teamviewer_i386.deb
				apt-get install -f -y
				rm -rf teamviewer_i386.deb
				;;
        
			5)
				#Skype for Linux
				echo "Installing Skype For Linux"
				apt install apt-transport-https -y
				curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
				echo "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
				apt update 
				apt install skypeforlinux -y
				;;
			esac
	done
fi
