#/bin/bash
#
# USDA Forest Service IBM TBSM 611 Install
# Date: 2014-05-30
# Author: Ron Compos, Glacier Technologies
# Desc: Create RHEL system user group ncoadmin
#       Primary group for user tbsmadm.
#

Group="ncoadmin"
NCOadmin=`grep "^${Group}" /etc/group`

echo "Checking for group: $Group"
if [ $NCOadmin ] ; then
    echo "  /etc/group: $NCOadmin"
    echo "Group exists: $Group"
else
    echo "Creating group: $Group"
    #echo "yast2 groups add groupname=$Group type=local"
    echo "groupadd $Group"
    groupadd $Group
fi


