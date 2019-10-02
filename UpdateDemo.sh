#!/bin/bash

# Demo module update for program

# Type: Demo
# Dev: Shell
# Date: 10/02/2019
# Author: KURO-CODE

#~~~~ Var ~~~~
Version="1.0"
PROGNAME="UpdateDemo"
AUTHOR="KURO-CODE"
WORKFOLDER="Work"
UPFILE="Update-version.txt"
CHECKUPDATE="wget https://raw.githubusercontent.com/$AUTHOR/Version/master/UPDATEDEMO/$UPFILE" 
CLONE="git clone https://github.com/$AUTHOR/$PROGNAME.git"

#~~~~ Colors ~~~~
W="\033[1;37m"
GR="\033[0;37m"
R="\033[1;31m"
G="\033[1;32m"
Y="\033[1;33m"
EC="\033[0m"

#~~~~ Update ~~~~
function Check_Version() {
	clear
	$CHECKUPDATE
	SOURCE=`pwd`
	if [ ! -f "$UPFILE" ]; then
    clear
		echo -e "${W}[${R}!${W}]File not exist!!!${EC}"
		sleep 1
		echo -e "${W}[${R}!${W}]Failure to update, ${EC}"
		sleep 3
#		exit
	else
		clear
		VERA=`echo $Version |sed 's/\.//g'`
		VERX=`cat $UPFILE`
		VER2=`echo $VERX |sed 's/\.//g'`
		echo -e "${G}Prog version${W}:${GR}.....${W}$Version \n${G}Update version${W}:${GR}...${W}$VERX"
		sleep 5
		if [ "$VERA" -ge "$VER2" ]; then
			clear
			echo -e "${W}[${G}+${W}]Version is${G} ok${EC}"
			sleep 3
			rm -f $UPFILE
		elif [ "$VERA" -lt "$VER2" ]; then
			clear
			echo -e "${W}[${R}!${W}]Update version${EC}"
			sleep 3
			$CLONE
			if [ ! -d "$PROGNAME" ]; then
				clear
				echo -e "${W}[${R}!${W}]File not exist!!!${EC}"
				sleep 3
				clear
				exit
			else
				clear
				echo -e "${W}[${R}!${W}]Update, please wait...${EC}"
				sleep 1
				if [ ! -d "$WORKFOLDER" ]; then
					echo
				else
					clear
					echo -e "${W}[${R}!${W}]Update, please wait...${EC}"
					sleep 1
					mv $WORKFOLDER $PROGNAME/$WORKFOLDER
				fi
				clear
				echo -e "${W}[${R}!${W}]Update, please wait...${EC}"
				sleep 1
				mv $PROGNAME /tmp/$PROGNAME
				cd ..
				rm -rf $SOURCE
				mv /tmp/$PROGNAME $PROGNAME
				clear
				echo -e "$W [$G""+$W] Update finished.\n Restart..."
				sleep 3
				cd $PROGNAME
				bash ./$PROGNAME.sh
				exit
			fi
		fi
	fi
}
Check_Version
