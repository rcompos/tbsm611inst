#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Modify password value in NCO config file
#       Password for system user root must be specified.
#
# Usage: ./cfg_pw_nco.sh <root_pw>
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Replace root password in NCO config file"

replacePw=$1
if [ "$replacePw" = "" ]; then
   replacePw="zAq12wsxcde#"
   echo "No password specified. Using default password."
fi

echo "Config file passwords: $replacePw"

searchPw="zAq12wsxcde#"

files="NCOMS.props"

for cfgfile in $files; do

    #echo "File: $cfgfile"

    echo "perl -i -pe \"s/$searchPw/$replacePw/g\" $cfgfile"
    perl -i -pe "s/$searchPw/$replacePw/g"  $cfgfile

done

exit 0

