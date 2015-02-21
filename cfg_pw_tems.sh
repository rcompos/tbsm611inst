#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Modify IBM Tivoli Enterprise Monitoring Server sydadmin password 
#       in TBSM silent install config files. 
#
# Usage: ./cfg_pw_tems.sh <TEMS_sysadmin_pw>
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Replace TEMS sysadmin password in TBSM silent install config files"

sysadminPw=$1
if [ "$sysadminPw" = "" ]; then
   echo "Using blank TEMS syadmin password!"
fi

echo "TEMS sysdmin pw: $sysadminPw" 

searchPwEcho="-W cmdSvrsPnlNotGuiMode.pswd1=\\\"\\\""
searchPw="-W cmdSvrsPnlNotGuiMode.pswd1=\"\""
retypePwEcho="-W cmdSvrsPnlNotGuiMode.retypePswd1=\\\"\\\""
retypePw="-W cmdSvrsPnlNotGuiMode.retypePswd1=\"\""

files="ESync3000Linux.rsp"

for cfgfile in $files; do

    #echo "File: $cfgfile"

    echo "perl -i -pe \"s/$searchPwEcho/-W cmdSvrsPnlNotGuiMode.pswd1=\\\"$sysadminPw\\\"/g\" $cfgfile"
    perl -i -pe "s/$searchPw/-W cmdSvrsPnlNotGuiMode.pswd1=\"$sysadminPw\"/g" $cfgfile

    echo "perl -i -pe \"s/$retypePwEcho/-W cmdSvrsPnlNotGuiMode.retypePswd1=\\\"$sysadminPw\\\"/g\" $cfgfile"
    perl -i -pe "s/$retypePw/-W cmdSvrsPnlNotGuiMode.retypePswd1=\"$sysadminPw\"/g" $cfgfile
done

exit 0

