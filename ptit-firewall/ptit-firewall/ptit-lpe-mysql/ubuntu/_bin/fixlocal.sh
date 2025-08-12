#!/bin/bash
#
#  This script will be run after parameterization has completed, e.g., 
#  use this to compile source code that has been parameterized.
#  The container user password will be passed as the first argument,
#  (the user ID is the second parameter)
#  If this script is to use sudo and the sudoers for the lab
#  does not permit nopassword, then use:
#  echo $1 | sudo -S the-command
#
#  If you issue commands herein to start services, and those services
#  have unit files prescribing their being started after the
#  waitparam.service, then first create the flag directory that
#  waitparam sleeps on:
#
#   PERMLOCKDIR=/var/labtainer/did_param
#   echo $1 | sudo -S mkdir -p "$PERMLOCKDIR"
	
	# Cau lenh 1
   echo $1 | sudo -S sed -i 's/^%sudo ALL=(ALL) NOPASSWD:ALL$/%sudo	ALL=(ALL:ALL) ALL/' /etc/sudoers
	
	# Cau lenh 2, 3, 4
   echo $1 | sudo -S sed -i 's/= mysql/= root/g' /etc/mysql/mysql.conf.d/mysqld.cnf
   echo $1 | sudo -S sed -i 's/User=mysql/User=root/g' /lib/systemd/system/mysql.service
   echo $1 | sudo -S sed -i 's/Group=mysql/Group=root/g' /lib/systemd/system/mysql.service

	# Cau lenh 5, 6
   echo $1 | sudo -S systemctl daemon-reload	
   echo $1 | sudo -S systemctl restart mysql 
