#/bin/env bash
#
# USDA Forest Service IBM TBSM 6.1.1 Install
# Date: 2014-08-18
# Author: Ron Compos, Glacier Technologies
# Desc: Extract TBSM files
#
# Usage: ./extract_tbsm.sh
#

echo "USDA Forest Service IBM TBSM 6.1.1"
echo "Extract TBSM files."

dir_base="/opt/IBM/tbsm611"

echo "Extract DB2 files."
echo "cd $dir_base"
cd $dir_base
echo "tar xvzf DB2_10_limited_CD_Linux_x86-64.tar.gz"
tar xvzf DB2_10_limited_CD_Linux_x86-64.tar.gz

echo "Extract TBSM files."
echo "cd $dir_base"
cd $dir_base
dir_tbsm="TBSM_V6.1.1_LINUX_64-BIT_MULTI"
echo "mkdir -m775 $dir_tbsm"
mkdir -m775 $dir_tbsm
echo "cd $dir_tbsm"
cd $dir_tbsm
echo "tar xvf ../${dir_tbsm}.tar"
tar xvf ../${dir_tbsm}.tar

echo "Extract SUF files."
echo "cd $dir_base"
cd $dir_base
dir_itm="ITM_V6.3.0_TOOLS_MP_ENGLISH"
echo "mkdir -m775 $dir_itm"
mkdir -m775 $dir_itm
echo "cd $dir_itm"
cd $dir_itm
echo "tar xvzf ../${dir_itm}.tar.gz"
tar xvzf ../${dir_itm}.tar.gz

echo "Extract FP1 files."
echo "cd $dir_base"
cd $dir_base
dir_fp1="6.1.1-TIV-BSM-FP0001-linux"
echo "mkdir -m775 $dir_fp1"
mkdir -m775 $dir_fp1
echo "cd $dir_fp1"
cd $dir_fp1
echo "tar xvf ../${dir_fp1}.tar"
tar xvf ../${dir_fp1}.tar

echo "Extract TBSM agent files."
echo "cd $dir_base"
cd $dir_base
dir_agent="KR9_lx8266CD-6.1.1-TIV-BSM-FP0001"
echo "mkdir -m775 $dir_agent"
mkdir -m775 $dir_agent
echo "cd $dir_agent"
cd $dir_agent
echo "tar xvzf ../${dir_agent}.tar.gz"
tar xvzf ../${dir_agent}.tar.gz

echo "Extract IBM pre-requisite checker."
echo "cd $dir_base"
cd $dir_base
dir_precheck=precheck_unix_20140505
echo "mkdir -m775 $dir_precheck"
mkdir -m775 $dir_precheck
echo "cd $dir_precheck"
cd $dir_precheck
echo "tar xvf ../${dir_precheck}.tar"
tar xvf ../${dir_precheck}.tar

exit 0

