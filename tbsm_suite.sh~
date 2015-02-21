#!/bin/sh
# ****************************************************** {COPYRIGHT-TOP-RM} ***
#  Licensed Materials - Property of IBM
#
#  "Restricted Materials of IBM"
#
#  5724-C51
#
#  (C) Copyright IBM Corp. 2007, 2011 All Rights Reserved.
#
#  US Government Users Restricted Rights - Use, duplication, or
#  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
# ****************************************************** {COPYRIGHT-END-RM} ***

# This is a simple script to startup TBSM and its associated components
# This script must be executed by the TBSM administrative user
# If a component does not appear to be found on this system, the script
# assumes that the installation is distributed and that the component
# has been started on another system.
#
#set -x

# USDA Forest Service environmental variables
export TBSM_HOME=/opt/IBM/tivoli/tbsm
export TIP_HOME=/opt/IBM/tivoli/tipv2

scriptdir="`dirname $0`"
if [ -f "${scriptdir}/setupTBSMData.sh" ]; then
  . ${scriptdir}/setupTBSMData.sh
fi
if [ -f "${scriptdir}/setupTBSMDash.sh" ]; then
  . ${scriptdir}/setupTBSMDash.sh
fi

# Verify that the TBSM_HOME environment variable has been set
if [ -z "${TBSM_HOME}" ]; then
  echo "The TBSM_HOME environment variable must be set."
  exit 1;
fi
# Verify that the TIP_HOME environment variable has been set
if [ -z "${TIP_HOME}" ]; then
  echo "The TIP_HOME environment variable must be set."
  exit 1;
fi

PROP_FILE="${TBSM_HOME}/etc/tbsm_suite.props"
# The following variables typically do not need to be modified but
# could be if necessary in PROP_FILE

# TBSM utilities
BIN_DIR="${TBSM_HOME}/bin"
# TBSM tools
TBSMTOOLS_BIN="${TBSM_HOME}/../tbsmtools/bin"
# Install directory of OMNIbus
OMNIHOME="${TBSM_HOME}/../netcool/omnibus"
# Profile name for the data server
DATAPROFILE=TBSMProfile
# Server name for the data server
DATASERVER=server1
# Profile name for the data server
DASHBOARDPROFILE=TIPProfile
# Server name for the dashboard server
DASHBOARDSERVER=server1
# Read the configuration properties as environment variables
eval `cat "${PROP_FILE}" | grep -v "^$" | grep -v "^#"`

# Verify running as the correct user
CURRENT_USER=`id 2>/dev/null| awk 'BEGIN{FS=")"}{split($1,a,"("); print a[2]; exit; }' -`
if [ "${CURRENT_USER}" != "${TBSM_ADMIN_USER}" ]; then
    echo "You must run $0 as user ${TBSM_ADMIN_USER}."
    echo "Please log in as ${TBSM_ADMIN_USER} to run this script."
    exit
fi

start_objserver () {
  # Start OMNIbus, so it will support non-ASCII chars:  d163765
  echo "Setting LANG based on platform, before starting OMNIbus"

  TEMP_LANG=$LANG
  os=`uname -a | awk -F' ' '{print $1}'`
  # echo $os

  if [ "$os" = "AIX" ]; then
     # echo "Inside AIX"
     LANG="EN_US.UTF-8"
     export LANG
  fi

  if [ "$os" = "HP-UX" ]; then
     # echo "Inside HP-UX"
     LANG="en_US.utf8"
     export LANG
  fi

  if [ "$os" = "Linux" ]; then
     # echo "Inside Linux"
     LANG="en_US.utf8"
     export LANG
  fi

  if [ "$os" = "SunOS" ]; then
     # echo "Inside SunOS"
     LANG="en_US.UTF-8"
     export LANG
  fi

  # echo $LANG

  # Run the command:
  #echo "Running:  $OMNIHOME/bin/nco_objserv -name ${OBJECTSERVER_NAME} & "
  #$OMNIHOME/bin/nco_objserv -name ${OBJECTSERVER_NAME} &
  echo "Start Netcool/OMNIbus process MasterObjectServer"
  echo "${OMNIHOME}/bin/nco_pa_start -process MasterObjectServer -user tbsmadm -password xxxxxx"
  ${OMNIHOME}/bin/nco_pa_start -process MasterObjectServer -user tbsmadm -password "zAq12wsxcde#"


  # Check for return code from last command:  stored in "$?"
  if [ "$?" -ne "0" ]; then
     # Error condition
     echo "Running the requested script, returned the following return code:  $?"
     exit 220
  fi

  # Wait for Server to start
  # echo "Running:  sleep 20"
  sleep 20

  # Run the command:
  echo "Running:  $OMNIHOME/bin/nco_ping ${OBJECTSERVER_NAME}  "
  svrck=`$OMNIHOME/bin/nco_ping ${OBJECTSERVER_NAME} | awk -F' ' '{print $3}' | grep -i available. | wc -l` 

  if [ "$svrck" -ne "1" ]; then
     #Error condition, OMNIbus is not running
     echo "ObjectServer is not running"
     exit 20 
  else
     echo "ObjectServer is running"
  fi

  # Reset LANG before leaving
  echo "Reseting: LANG=$TEMP_LANG"
  LANG=$TEMP_LANG
  export LANG
}

# Start or stop the server processes as requested
case $1 in
  start)
    # If object server installed, then start it
    if [ -f "${OMNIHOME}/bin/nco_objserv" ]; then
      start_objserver
    fi

    echo "Start Netcool/OMNIbus process EIF Probe"
    echo "${OMNIHOME}/bin/nco_pa_start -process EIF_Probe -user tbsmadm -password xxxxxx"
    ${OMNIHOME}/bin/nco_pa_start -process EIF_Probe -user tbsmadm -password "zAq12wsxcde#"

    # If requested, start omnibus bidirectional gateway
    #if [ "${START_BIDIR_GATEWAY}" != "0" ] ; then
    #  if [ -x "${BIN_DIR}/g_objserv_bi_start.sh" ] ; then
    #    "${BIN_DIR}/g_objserv_bi_start.sh" "${OMNIHOME}"
    #  fi
    #fi

    # If data server exists, start it
    if [ -x "${TIP_HOME}/profiles/${DATAPROFILE}/bin/startServer.sh" ]; then
      "${TIP_HOME}/profiles/${DATAPROFILE}/bin/startServer.sh" "${DATASERVER}"
    else
      echo "TBSM data server not installed"
    fi

    # If dashboard server exists, start it
    if [ -x "${TIP_HOME}/profiles/${DASHBOARDPROFILE}/bin/startServer.sh" ]; then
      "${TIP_HOME}/profiles/${DASHBOARDPROFILE}/bin/startServer.sh" "${DASHBOARDSERVER}"
    else
      echo "TBSM dashboard server not installed"
    fi

    # If SUF exists, start it
    STARTSUF="/opt/IBM/SitForwarder/bin/startSUF.sh"
    if [ -x "$STARTSUF" ]; then
      echo "Start ITM Situation Update Forwarder"
      echo "$STARTSUF"
      $STARTSUF > /dev/null 2>&1
    else
      echo "SUF not installed"
    fi

    ;;

  stop)

    # If SUF exists, stop it
    STOPSUF="/opt/IBM/SitForwarder/bin/stopSUF.sh"
    if [ -x "$STOPSUF" ]; then
      echo "Stop ITM Situation Update Forwarder"
      echo "$STOPSUF"
      $STOPSUF > /dev/null 2>&1
    else
      echo "SUF not installed"
    fi

    # Stop dashboard server if running
    pidfile="${TIP_HOME}/profiles/${DASHBOARDPROFILE}/logs/${DASHBOARDSERVER}/${DASHBOARDSERVER}.pid"
    if [ -r "${pidfile}" ] ; then
      kill `cat "${pidfile}"`
      echo "TBSM dashboard server stop requested"
    else
      echo "TBSM dashboard server not installed or not running"
    fi

    # Stop data server if running
    pidfile="${TIP_HOME}/profiles/${DATAPROFILE}/logs/${DATASERVER}/${DATASERVER}.pid"
    if [ -r "${pidfile}" ] ; then
      kill `cat "${pidfile}"`
      echo "TBSM data server stop requested"
    else
      echo "TBSM data server not installed or not running"
    fi

    # Stop gateway if configured
    #if [ "${START_BIDIR_GATEWAY}" != "0" ] ; then
    #  pidfile="${OMNIHOME}/var/NCO_GATE.pid"
    #  if [ -r "${pidfile}" ] ; then
    #    kill `cat "${pidfile}"`
    #    echo "OMNIbus bidirectional gateway stop requested"
    #  else
    #    echo "OMNIbus bidirectional gateway not installed or not running"
    #  fi
    #fi

    echo "Stop Netcool/OMNIbus EIF Probe"
    echo "${OMNIHOME}/bin/nco_pa_stop -process EIF_Probe -user tbsmadm -password xxxxxx"
    ${OMNIHOME}/bin/nco_pa_stop -process EIF_Probe -user tbsmadm -password "zAq12wsxcde#"

    # Stop OMNIbus
    # If object server installed, then stop it
    #pidfile="${OMNIHOME}/var/${OBJECTSERVER_NAME}.pid"
    #if [ -r "${pidfile}" ]; then
    #  kill `cat "${pidfile}"`
    #  echo "ObjectServer stop requested"
    #else
    #  echo "ObjectServer not installed or not running"
    #fi

    echo "Stop Netcool/OMNIbus ObjectServer"
    echo "${OMNIHOME}/bin/nco_pa_stop -process MasterObjectServer -user tbsmadm -password xxxxxx"
    ${OMNIHOME}/bin/nco_pa_stop -process MasterObjectServer -user tbsmadm -password "zAq12wsxcde#"

    ;;

  *)
    echo "Usage: `basename $0` start|stop"
    exit 1
    ;;
esac


exit 0
