#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Create system user tbsmadm and group ncoadmin
# Must be run from same directory as crt_tbsmadm.sh and crt_ncoadmin.sh
#
# Usage: ./crt_user.sh
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Create users and groups"
echo 

echo "./crt_ncoadmin.sh"
./crt_ncoadmin.sh

echo "./crt_tbsmadm.sh"
./crt_tbsmadm.sh

echo "chage -M \"-1\" tbsmadm"
chage -M "-1" tbsmadm

echo "cp -p /opt/IBM/tbsm611/tbsm611inst/.tbsmprof ."
cp -p /opt/IBM/tbsm611/tbsm611inst/.tbsmprof /home/tbsmadm

echo "cp -p /opt/IBM/tbsm611/tbsm611inst/.bashrc ."
cp -p /opt/IBM/tbsm611/tbsm611inst/.bashrc /home/tbsmadm

echo "usermod -a -G ncoadmin root"
usermod -a -G ncoadmin root

echo "chmod 775 /opt/IBM"
chmod 775 /opt/IBM

echo "chown -R tbsmadm.ncoadmin /opt/IBM"
chown -R tbsmadm.ncoadmin /opt/IBM

echo "chown -R tbsmadm.ncoadmin /home/tbsmadm"
chown -R tbsmadm.ncoadmin /home/tbsmadm

exit 0

