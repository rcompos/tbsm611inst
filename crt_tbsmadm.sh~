#/bin/bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-05-30
# Author: Ron Compos, Glacier Technologies
# Desc: Create RHEL 5 system user "tbsmadm"
#       Non-root user tbsmadm for TBSM 6.1.1
#       Subscribe to groups ncoadmin
#

User="tbsmadm"
Group="ncoadmin"
pwraw="zAq12wsxcde#"
#Pw='$6$r0TrN3DMVXMMLFkC$aZHChxjUINw06SHnOUId8Qs6iO9aSJxNp009Q96s6HjUTVE5bun9cVHDAnoDTW2z7.96gXBsx8v/zPJUkEk3m.'
GroupLine=`grep "^${Group}:" /etc/group`
GIDncoadmin=`grep "^${Group}:" /etc/group|cut -d: -f3`
#echo "Checking for group: $Group"

if [ $GIDncoadmin ] ; then
    #echo "  /etc/group: $GroupLine"
    #echo "Group exists: $Group"
    echo "Checking for user: $User"
    UserLine=`grep "^${User}:" /etc/passwd`
    Result=$?  # Result of grep on /etc/passwd
    #echo "Result: $Result"
    if [ $Result -eq 0 ]; then
        echo "  /etc/passwd: $UserLine"
        echo "User exists: $User"
    else
        echo "Creating user: $User"
        Pw=`python -c "import crypt,getpass,pwd; print crypt.crypt('${pwraw}','\\$6\\$1234567890123456\\$')"`
        echo "useradd -c TBSMuser -p $Pw -g $GIDncoadmin -G root $User"
        useradd -c TBSMuser -p $Pw -f "-1" -g $GIDncoadmin -G root $User 
    fi
else
    echo "Group does not exist: $Group"
    echo "$Group must be created before running this script."
    exit 1
fi

exit 0
