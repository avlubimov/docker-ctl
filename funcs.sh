#!/bin/bash

DIRPROFILE="${ROOT}/profiles"


function PrintUsage {
    echo 
    echo "usage $0 status | start | stop | restart | shell "
    echo "Options:"
    echo "-p profile - set profile (default profile default)"
    echo "-d - debug mode"
    echo "-h - ptint help and exit"
    echo "Examples:"
    echo "$0 start - start container"
    echo "$0 stop - stop container"
    echo "$0 -p cups-ubuntu restart - restart container with profile cups-ubuntu"
    echo ""
}

function DebugMSG {
    echo 
    echo "DEBUG: $1"
    echo
}



function PrintStatus {
    echo ""
    echo "Profile: ${PROFILE}"
    echo "Container: ${CONTAINER}"
    echo "Command: ${COMMAND}"
    echo ""
}

function UsageExit {
  PrintUsage
  exit $1
}

function ErrorExit {
  echo $1
  exit 5
}

function DoShell {

  [[ -v DEBUG ]] && DebugMSG  "docker  exec -it  ${CONTAINER} $SHELL"
  docker  exec -it  ${CONTAINER} $SHELL
  exit 0
}

function DoStop {
  [[ -v DEBUG ]] && DebugMSG "docker stop ${CONTAINER}"
  docker stop ${CONTAINER}
  exit 0
}

function DoStart {
  [[ -v DEBUG ]] && DebugMSG "docker start ${CONTAINER}"
  docker start ${CONTAINER}
  exit 0
}

function DoRestart {
  [[ -v DEBUG ]] && DebugMSG "docker restart ${CONTAINER}"
  docker restart ${CONTAINER}
  echo ""
  exit 0
}

function DoInit {
  RUNSCRIPT="${PROFILE}/init.sh"
  [[ -v DEBUG ]] && DebugMSG "Run ${RUNSCRIPT}"
  [[ -f ${RUNSCRIPT} ]] || ErrorExit  "File ${RUNSCRIPT} not found!"
  . ${RUNSCRIPT}
  exit 0
}

function DoBuild {
  RUNSCRIPT="${PROFILE}/build.sh"
  [[ -v DEBUG ]] && DebugMSG "Run ${RUNSCRIPT}"
  [[ -f ${RUNSCRIPT} ]] || ErrorExit  "File ${RUNSCRIPT} not found!"
  . ${RUNSCRIPT}
  exit 0
}

function DoRun {
  RUNSCRIPT="${PROFILE}/run.sh"
  [[ -v DEBUG ]] && DebugMSG "Run ${RUNSCRIPT}"
  [[ -f ${RUNSCRIPT} ]] || ErrorExit  "File ${RUNSCRIPT} not found!"
  . ${RUNSCRIPT}
  echo ""
  exit 0
}

function DoStatus {
  [[ -v DEBUG ]] && DebugMSG "docker ps -a --filter name=${CONTAINER} --format {{.Names}}({{.ID}}): {{.State}}"
  docker ps -a --filter name="${CONTAINER}" --format "{{.Names}}({{.ID}}): {{.State}}"
  echo ""
  exit 0
}



function GetOpts {
    PROFILE="${DIRPROFILE}/default"
    while getopts "dhp:" options
	do
	    case "${options}" in
		p) PROFILE="${DIRPROFILE}/${OPTARG}"
		;;
		h) UsageExit 0
		;;
		d) DEBUG=1
		;;
		:) UsageExit 5
    		;;
		*) UsageExit 5
		;;
	    esac
	done  
    shift $(($OPTIND - 1))
    COMMAND=$1
}




