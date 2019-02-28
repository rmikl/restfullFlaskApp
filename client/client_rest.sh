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

count="`curl -X GET $hostname/`"


echo

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
			    let count=$count+1
			    curl -d "id=$count&username=$username" -X POST $hostname/set_new_user
           		;;
         
       		2)
       		    echo "Username:"
		        read username
		        result="`curl -d "user=$username" -X GET $hostname/get_user`"
			    echo
			    echo -E  "ID	USERNAME"
			    echo $result | sed "s/\[//g" | sed "s/\]//g" | tr , '\n' | sed "s/^ //g"
            	;;
         
        	3)
            	echo "Deleting User..."
            	;;
        	4)
			    result="`curl -X GET $hostname/get_users`"
			    echo
			    echo -E  "ID	USERNAME"
			    echo $result | sed "s/\[//g" | sed "s/\]//g" | tr , '\n' | sed "s/^ //g"
			    echo ""
            		;;
        	5)
            	echo "Deleting all users..."
			    curl -X POST $hostname/del
            	;;
           	*)
			echo "exit"
			exit 1
    esac
done 
