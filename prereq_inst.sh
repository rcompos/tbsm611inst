#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Install dependent packages
#
# Usage: ./prereq_inst.sh 
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Install pre-requisite system packages"

RhPackageList="compat-libstdc++-33.x86_64 compat-libstdc++-33.i686 compat-db.x86_64 compat-db.i686 openmotif22.i686 ksh.x86_64 gtk2.i686 gtk2-engines.x86_64 gtk2-engines.i686 libXp.x86_64 libXmu.x86_64 libXtst.i686 pam.i686 compat-libstdc++-296.i686"

for Pkg in $RhPackageList; do
    echo "yum -y install $Pkg"
    yum -y install $Pkg
done


exit 0

