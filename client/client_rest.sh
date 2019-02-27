#!/bin/bash



if [[ "$1" == "--help" ]];then
	echo "usage: ./script address port"
	echo "address - the client address"
	exit 0
fi

hostname="0.0.0.0"


if [[ "$1" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
  	hostname=$1
  	echo "hostname assigned"
else 
	echo "U need to provide valid ip address of the server"
	exit 1
fi

while :
do 
	echo "1) Add User"
	echo "2) Print User"
	echo "3) Delete User"
	echo "4) Print all users"
	echo "5) Delete all users"
	echo "other key is exit"
	read var
	read pause
	case "$var" in
        	1)
            		echo "Adding User..."
			echo "Username:"
			read username
			echo "id:"
			read id
			curl -d "id=$id&username=$username" -X POST $hostname/set_new_user
           		;;
         
       		2)
			echo "Printing User..."
            		;;
         
        	3)
            		echo "Deleting User..."
            		;;
        	4)
			result="`curl -X GET $hostname/get_users`"
			echo -E  "\nID	USERNAME"
			echo $result | sed "s/\[//g" | sed "s/\]//g" | sed "s/, /\n/g" | sed "s/User(//g" | sed "s/'//g" | sed "s/)//g" | awk -F, '{print $1,$2}'
			echo ""
            		;;
        	5)
            		echo "Deleting all users..."
			curl -X POST 18.218.8.145/del
            		;;
         
        	*)
			echo "exit"
			exit 1
            exit 1
 
esac
done 
