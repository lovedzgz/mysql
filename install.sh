#!/bin/sh
cd $(dirname $0;pwd)
rpm -Uvh mysql.rpm
yum -y install mysql-community-server.x86_64
service mysqld start
mysql_pwd=`cat /var/log/mysqld.log | grep root@localhost | cut -d : -f 4 | sed s/[[:space:]]//g`
mysql -uroot -hlocalhost --password=$mysql_pwd --connect-expired-password << EOF
	set global validate_password_policy=0;
	set global validate_password_length=1;
	set global validate_password_mixed_case_count=2;
	alter user user() identified by '123456';
	flush privileges;
EOF
echo "mysql pwd is 123456"
