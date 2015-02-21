#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Create fresh set of config files.
#       Must be run from same dir where config files reside
#
# Usage: ./fresh_file.sh 
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Create fresh config file set."

filesTilde=`find . -name "*~" | perl -pe 's/\.\/(\S+)~/$1/g'`

for file in $filesTilde; do

   echo "cp -f ${file}~ $file"
   cp -f ${file}~ $file

done

exit 0

