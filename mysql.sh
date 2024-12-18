#!/bin/bash

source ./common.sh

check_root

echo "Please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE

systemctl enable mysqld &>>$LOGFILE


systemctl start mysqld &>>$LOGFILE

mysql -h db.aws-9s.shop -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
   mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
else 
    echo -e "MySQL Root password is already setup...$R SKIPPING $N"
fi 