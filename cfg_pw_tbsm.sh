#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Modify password values in TBSM config files for silent install
#       Applies to tbsmadm, db2inst1, dasusr1, db2fenc1
#
# Usage: ./cfg_pw_tbsm.sh <TBSM_pw>
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Replace password values in TBSM silent install config files"
echo "Passwords for users tbsmadm, db2inst1, dasusr1 & db2fenc1 must"
echo "already be set to given value."

replacePw=$1
if [ "$replacePw" = "" ]; then
   replacePw="zAq12wsxcde#"
   echo "No password specified. Using default password."
fi

echo "Config file passwords: $replacePw"

searchPw="zAq12wsxcde#"

files="crt_tbsmadm.sh db2wse.rsp dbconfig-installer.properties setup.rsp tbsm_suite.sh"

for cfgfile in $files; do

    #echo "File: $cfgfile"

    echo "perl -i -pe \"s/$searchPw/$replacePw/g\" $cfgfile"
    perl -i -pe "s/$searchPw/$replacePw/g" $cfgfile

done

exit 0

