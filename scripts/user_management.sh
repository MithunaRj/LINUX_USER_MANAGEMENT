#!/bin/bash
#output_file=reports/user_management.log
echo "    "
read -p "Enter Username: " username
User=$(id $username >> /dev/null 2>&1)
if [ $? -eq 0 ]; then
        echo "User exists"
else
        echo "User doesn't exist"
        
fi
