#!/bin/bash

service nginx status
service php7.3-fpm status
service mysql status

cd /etc/nginx/sites-available/

printf "\n\e[1;34mNGINX fast-config menu\e[0m\n"
printf "1.INDEX\t\t2.SSL\t\t3.EXIT\n"
echo -n "option: "
read VAR

if [ -z $VAR ]
	then
	echo "ERROR: no argument was given! Exiting..."
	exit
elif [ $VAR = "1" ]
	then
	printf "\n\e[1;34mAUTO-INDEX\e[0m\n"
	printf "1.ON\n2.OFF\n3.EXIT\n"
	echo -n "option: "
	read VAR
	if [ -z $VAR ]
		then
		echo "ERROR: no argument was given! Exiting..."
		exit
	elif [ $VAR = '1' ]
		then
		echo "autoindex ON"
		patch -f --no-backup-if-mismatch default index_on
		service nginx reload
	elif [ $VAR = "2" ]
		then
		echo "autoindex OFF"
		patch -f --no-backup-if-mismatch default index_off
		service nginx reload
	elif [ $VAR	= "3" ]
		then
		echo "Bye!"
		exit
	else
		echo "ERROR: '$VAR' is not a valid argument! Exiting..."
	fi
elif [ $VAR	= "2" ]
	then
	printf "\n\e[1;34mSSL CONFIG\e[0m\n"
	printf "1.SSL ONLY\t(redirect http to https)\n2.OPEN\t\t(allow both http & https requests)\n3.EXIT\n"
		echo -n "option: "
	read VAR
	if [ -z $VAR ]
		then
		echo "ERROR: no argument was given! Exiting..."
		exit
	elif [ $VAR = '1' ]
		then
		printf "\nSSL ONLY\t(redirect http to https)\n"
		patch -f --no-backup-if-mismatch default ssl_only
		service nginx reload
	elif [ $VAR = "2" ]
		then
		printf "\nOPEN\t\t(allow both http & https requests)\n"
		patch -f --no-backup-if-mismatch default ssl_open
		service nginx reload
	elif [ $VAR	= "3" ]
		then
		echo "Bye!"
		exit
	else
		echo "ERROR: '$VAR' is not a valid argument! Exiting..."
	fi
elif [ $VAR	= "3" ]
	then
	echo "Bye!"
	exit
else
	echo "ERROR: '$VAR' is not a valid argument! Exiting..."
fi