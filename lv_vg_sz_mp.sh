#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Create filesystem as specified
#
# Usage: ./lv_sz_mp.sh <LVname> <VolumeGroup> <SizeGB> <MountPoint> <NoMount>
#

LVname=$1
VGname=$2
LVsize=$3
MountPt=$4
NoMount=$5

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Create filesystem"
echo "Logical Volume: $LVname"
echo "Volume Group: $VGname"
echo "LV size: ${LVsize}GB"
echo "Mount point: $MountPt"
echo

lvs $VGname/$LVname
if [ $? = 0 ]; then
   echo "Logical volume already exists: $VGname/$LVname"
   exit 11
fi

if [ "$LVname" = "" ]; then
   echo "Logical volume name must be specified as first argument."
   exit 15;
fi

if [ "$LVsize" = "" ]; then
   echo "Logical volume size must be specified as second argument."
   exit 17;
fi

if [ "$MountPt" = "" ]; then
   echo "Mount point must be specified as third argument."
   exit 19;
fi

echo "lvcreate -L ${LVsize}G -n $LVname $VGname"
lvcreate -L ${LVsize}G -n $LVname $VGname

echo "mkfs.ext4 /dev/$VGname/$LVname"
mkfs.ext4 /dev/$VGname/$LVname

echo "Checking /etc/fstab for previous entry"
grep -i "$VGname/$LVname" /etc/fstab

if [ $? = 1 ]; then
   echo "/dev/$VGname/$LVname        $MountPt                ext4    defaults              1 2"
   echo "/dev/$VGname/$LVname        $MountPt                ext4    defaults              1 2" >> /etc/fstab
fi

if [ "$NoMount" = "" ]; then
   echo "mkdir $MountPt"
   mkdir $MountPt
   echo "mount $MountPt"
   mount $MountPt
   echo "df -h $MountPt"
   df -h $MountPt
fi

exit 0

