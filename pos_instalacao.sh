#!/bin/bash

clear

if [[ $EUID -ne 0 ]]; then
    echo -e "\033[5;31m Esse script deve ser executado como root \033[0m"
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt update && apt upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Git" off    # any option can be set to default to "on"
	         2 "Vim" off
           3 "Oh My Zsh"
	         4 "Atom" off
           5 "Google Chrome" off
           6 "Terminator" off
           7 "Android Studio" off
           8 "Wine" off
           9 "Nvidia Drivers" off
           10 "Vulkan para Nvidia" off
           11 "Lutris" off
           12 "Steam" off
	         )
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	      1)
				echo -e "\033[1;33m Instalando Git \033[0m"
				apt update
				apt install git -y
				;;

				2)
				echo -e "\033[1;33m Instalando Vim \033[0m"
				apt update
				apt install vim -y
				;;

        3)
        apt install zsh -y
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        apt-get install fonts-powerline -y
        ;;

        4)
        echo -e "\033[1;33m Instalando Atom \033[0m"
        wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
        sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
        apt update
        apt install atom -y
				;;

        5)
        echo -e "\033[1;33m Instalando Google Chrome \033[0m"
				wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
				dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb
				;;

        6)
        echo -e "\033[1;33m Terminator \033[0m"
				apt update
				apt install terminator
        ;;

        7)
        echo -e "\033[1;33m Instalando Android Studio \033[0m"
				wget https://dl.google.com/dl/android/studio/ide-zips/3.4.0.18/android-studio-ide-183.5452501-linux.tar.gz
        echo -e "\033[5;33m Extraindo Android Studio... \033[0m"
        tar -xf android-studio-ide-183.5452501-linux.tar.gz -C /opt
        rm android-studio-ide-183.5452501-linux.tar.gz
        sh /opt/android-studio/bin/studio.sh
				;;

        8)
        echo -e "\033[1;33m Instalando Wine \033[0m"
        dpkg --add-architecture i386
        wget -nc https://dl.winehq.org/wine-builds/winehq.key
        apt-key add winehq.key
        apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main' -y
        apt update
        apt install --install-recommends winehq-staging -y
        apt install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 -y
        ;;

        9)
        echo -e "\033[1;33m Instalando Drivers Nvidia \033[0m"
        add-apt-repository ppa:graphics-drivers/ppa -y
        apt update
        apt install nvidia-driver-418 -y
        ;;

        10)
        echo -e "\033[1;33m Instalando Vulkan para Nvidia \033[0m"
        apt update
        apt install libvulkan1 libvulkan1:i386 -y
        ;;

        11)
        echo -e "\033[1;33m Instalando Lutris \033[0m"
        add-apt-repository ppa:lutris-team/lutris -y
        apt update
        apt install lutris -y
        ;;

        12)
        echo -e "\033[1;33m Instalando Steam \033[0m"
        https://steamcdn-a.akamaihd.net/client/installer/steam.deb
        dpkg -i steam_latest.deb
        rm steam_latest.deb
        ;;

	    esac
	done
fi
