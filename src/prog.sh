#!/bin/bash

# shell script
#
# netgrab: network host scanner
# author: synfosec

interfaces=$(ip link show | cut -d ' ' -f 2 | grep -E '\w' | sed 's/://g')

function helpmenu()
{
	echo "usage: netgrab [BASE_IP] [INTERFACE]"
	echo -e "grabs all hosts on the network\n"
	echo "synopsis:"
	echo -e "\tnetgrab.sh 192.168.1 enp1s0\n"
	echo -e "OPTIONS:\n"
	echo -e "\t-h, --help\t\thelp menu"
}

function banner(){
	echo "@@@  @@@  @@@@@@@@  @@@@@@@   @@@@@@@@  @@@@@@@    @@@@@@   @@@@@@@"
	echo "@@@@ @@@  @@@@@@@@  @@@@@@@  @@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@ "
	echo "@@!@!@@@  @@!         @@!    !@@        @@!  @@@  @@!  @@@  @@!  @@@ " 
	echo "!@!!@!@!  !@!         !@!    !@!        !@!  @!@  !@!  @!@  !@   @!@ " 
	echo "@!@ !!@!  @!!!:!      @!!    !@! @!@!@  @!@!!@!   @!@!@!@!  @!@!@!@  " 
	echo "!@!  !!!  !!!!!:      !!!    !!! !!@!!  !!@!@!    !!!@!!!!  !!!@!!!! " 
	echo "!!:  !!!  !!:         !!:    :!!   !!:  !!: :!!   !!:  !!!  !!:  !!! " 
	echo ":!:  !:!  :!:         :!:    :!:   !::  :!:  !:!  :!:  !:!  :!:  !:! " 
	echo " ::   ::   :: ::::     ::     ::: ::::  ::   :::  ::   :::   :: :::: " 
	echo -e "::    :   : :: ::      :      :: :: :    :   : :   :   : :  :: : ::  \n" 
	echo -e "			  [ by synfo ]\n"
}

function commandcheck()
{
	if command -v ping -c 1 google.com &> /dev/null && command -v dig &> /dev/null; then
		check="good"
	else
		echo -e "[-] Missing dependecies: Commands needed \"dig\" \"ping\"\n"
		echo "exiting status 1"
		exit 1
	fi
}

function inters()
{
	newline
	echo $interfaces
	newline
}

if [ "$#" != 2 ]; then
	commandcheck
	helpmenu
	exit 1
else
	commandcheck
	if echo "$2" | grep -q "$interfaces"; then
		clear
		banner
		echo -e "[+] sweeping $1.0/24 on $2...\n"

		for host in `seq 1 254`; do
			
			ping -I $2 -c 1 $1.$host | grep "64 bytes" | cut -d " " -f 4 | sed "s/://g" &

		done

		echo -e "\n[+] All hosts"
		exit 0

	else
		clear
		banner
		echo -e "$interfaces\n"
		echo "[-] $2 is not a valid interface"
		exit 1
	fi
fi
