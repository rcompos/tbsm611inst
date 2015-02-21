#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Modify hostname value in TBSM config files for silent install
#       FQDN will be determined by 'hostname -f'
#       Shortname will be  determined by 'hostname'
#
# Usage: ./cfg_hostname_tbsm.sh
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Replace hostname value in TBSM silent install config files"

shortname=`hostname`
fqdn=`hostname -f`
echo "Shortname: $shortname" 
echo "FQDN: $fqdn" 

searchFqdn="fsxopsxtbsm.wrk.fs.usda.gov"
searchShort="fsxopsxtbsm"
files="nco_pa.conf setup.rsp"

for cfgfile in $files; do
    #echo "File: $cfgfile"
    echo "perl -i -pe \"s/$searchFqdn/$fqdn/g\" $cfgfile"
    perl -i -pe "s/$searchFqdn/$fqdn/g" $cfgfile
    echo "perl -i -pe \"s/$searchShort/$shortname/g\" $cfgfile"
    perl -i -pe "s/$searchShort/$shortname/g" $cfgfile
done

exit 0

