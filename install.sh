#!/bin/bash


iden=$(id | cut -d " " -f 1 | cut -d "=" -f 2 | cut -d "(" -f 1)

function usage()
{
	echo -e "usage: install.sh [OPTION]\ninstall script\n\nOPTIONS:\n\tinstall:\tinstalls script\n\tuninstall:\tuninstalls script\n"
	echo "exiting status 1"
	exit 1
}

if [ "$#" != 1 ]; then
	usage
else
	if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
		usage
	fi

	if [ "$iden" != 0 ]; then
		echo -e "[-] needs to run as root\n"
		echo "exiting status 1"
		exit 1
	else
		if [ "$1" == "install" ]; then
			echo -e "[+] Installing NetGrab\n"
			sudo cp src/prog.sh /usr/local/bin/netgrab
			exit 0
		elif [ "$1" == "uninstall" ]; then
			sudo rm $(which netgrab)
			exit 0
		else
			echo -e "[-] '$1' is not a valid option\nexiting status 1"
			exit 1
		fi
	fi
fi
