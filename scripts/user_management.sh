#!/bin/bash
#output_file=reports/user_management.log
echo "    "
read -p "Enter Username: " username
if  id "$username" >> /dev/null 2>&1; then
        echo "User exists"
	User_details=$(id $username)
	echo "User details: $User_details"
else
        echo "User doesn't exist"
        
fi
echo "    "
User_List=$(cut -d : -f 1 /etc/passwd)
echo "Users_List:" 
echo "$User_List"
