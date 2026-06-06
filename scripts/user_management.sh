#!/bin/bash
#output_file=reports/user_management.log
echo "    "
read -p "Enter Username: " username
if  id "$username" > /dev/null 2>&1; then
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
	sudo useradd -m "$New_User"
	if [ $? -eq 0 ]; then
		echo "User Created Successfully"
		sudo passwd "$New_User"
	        New_User_Details=$(id "$New_User")
	        echo "New User Details: $New_User_Details"
	else
		echo "User creation failed"
	fi
fi
read -p " Enter User name  to lock a user:" User
if id "$User" > /dev/null 2>&1; then
	        status=$(sudo passwd -S "$User" | awk '{print $2}')
	        if [ "$status" == "L" ]; then
			echo " User is already Locked"
		else

	                echo "Locking User:"
		        sudo passwd -l $User
			if [ $? -eq 0 ]; then
				echo "User Locked successfully"
			else
				echo "User Lock failed"
			fi
		fi
else
	        echo "User doesn't exists"
fi
read -p "Enter Usernmae to unlock a user:" Unlock_User
if id "$Unlock_User" > /dev/null 2>&1; then
	status=$(sudo passwd -S "$Unlock_User" | awk '{print $2}')
	if [ "$status" == "P" ]; then
		echo "User is not locked"
	else
		echo "Unlocking User"
		sudo passwd -u "$Unlock_User"
		if [ $? -eq 0 ]; then
			echo "Unlocking User is successfull"
		else
			echo "Unlocking user failed"
		fi
	fi
else
	echo "User doesn't exist"
fi


