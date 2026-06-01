#!/bin/bash
#output_file=reports/user_management.log
echo "    "
read -p "Enter Username: " username
if  id "$username" >> /dev/null 2>&1; then
        echo "User exists"
	User_details=$(id "$username")
	echo "User details: $User_details"
else
        echo "User doesn't exist"
        
fi
echo "    "
User_List=$(cut -d : -f 1 /etc/passwd)
echo "Users_List:" 
echo "$User_List"
read -p " Enter New User name  to create a user:" New_User
if id "$New_User" > /dev/null 2>&1; then
	echo " User already exist"
else
	sudo useradd -m $New_User
	if [ $? -eq 0 ]; then
		echo "User Created Successfully"
	        New_User_Details=$(id "$New_User")
	        echo "New User Details: $New_User_Details"
	else
		echo "User creation failed"
	fi
fi

