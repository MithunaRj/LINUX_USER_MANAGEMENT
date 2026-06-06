#!/bin/bash
output_file=reports/user_management.log
echo "    " >> "$output_file"
Date=$(date)
echo "$Date"  >> "$output_file"
read -p "Enter Username: " username
if  id "$username" > /dev/null 2>&1; then
        echo "User exists" >> "$output_file"
	User_details=$(id "$username")
	echo "User details: $User_details" >> "$output_file"
else
        echo "User doesn't exist" >> "$output_file"
        
fi
echo "    "
User_List=$(cut -d : -f 1 /etc/passwd)
echo "Users_List:" >> "$output_file"
echo "$User_List" >> "$output_file"
read -p " Enter New User name  to create a user:" New_User
if id "$New_User" > /dev/null 2>&1; then
	echo " User already exist" >> "$output_file"
else
	sudo useradd -m "$New_User"
	if [ $? -eq 0 ]; then
		echo "User Created Successfully" >> "$output_file"
		sudo passwd "$New_User" 
	        New_User_Details=$(id "$New_User")
	        echo "New User Details: $New_User_Details" >> "$output_file"
	else
		echo "User creation failed" >> "$output_file"
	fi
fi
read -p " Enter User name  to lock a user:" User
if id "$User" > /dev/null 2>&1; then
	        status=$(sudo passwd -S "$User" | awk '{print $2}')
	        if [ "$status" == "L" ]; then
			echo " User is already Locked" >> "$output_file"
		else

	                echo "Locking User:" >> "$output_file"
		        sudo passwd -l $User
			if [ $? -eq 0 ]; then
				echo "User Locked successfully" >> "$output_file"
			else
				echo "User Lock failed" >> "$output_file"
			fi
		fi
else
	        echo "User doesn't exists" >> "$output_file"
fi
read -p "Enter Usernmae to unlock a user:" Unlock_User
if id "$Unlock_User" > /dev/null 2>&1; then
	status=$(sudo passwd -S "$Unlock_User" | awk '{print $2}')
	if [ "$status" == "P" ]; then
		echo "User is not locked" >> "$output_file"
	else
		echo "Unlocking User" >> "$output_file"
		sudo passwd -u "$Unlock_User"
		if [ $? -eq 0 ]; then
			echo "Unlocking User is successfull" >> "$output_file"
		else
			echo "Unlocking user failed" >> "$output_file"
		fi
	fi
else
	echo "User doesn't exist" >> "$output_file"
fi

read -p "Enter Username to delete a user;" User_Del
if id "$User_Del" > /dev/null 2>&1; then
	echo "Deleting User" >> "$output_file"
	sudo userdel -r $User_Del
	if [ $? -eq 0 ]; then
		echo "User deleted successfully" >> "$output_file"
	else
		echo "User deletion failed" >> "$output_file"
	fi
else
	echo "User doesn't exist" >> "$output_file"
fi

	
