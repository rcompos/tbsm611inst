#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Modify IBM Tivoli Enterprise Monitoring Server hostname value in 
#       TBSM silent install config files. 
#
# Usage: ./cfg_hostname_tems.sh <TEMS_FQDN>
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Replace TEMS FQDN value in TBSM silent install config files"

fqdnTems=$1
if [ "$fqdnTems" = "" ]; then
   echo "TEMS FQDN must be specified only argument."
   exit 15;
fi

echo "TEMS FQDN: $fqdnTems" 

searchFqdn="fsxopsxtems.wrk.fs.usda.gov"
files="ESync3000Linux.rsp silent_config.txt"

for cfgfile in $files; do
    #echo "File: $cfgfile"
    echo "perl -i -pe \"s/$searchFqdn/$fqdnTems/g\" $cfgfile"
    perl -i -pe "s/$searchFqdn/$fqdnTems/g" $cfgfile
done

exit 0

