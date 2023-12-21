#!/bin/bash

function GetPrefix {
    SRC=$1
    while [[ -L "${SRC}" ]]
    do
	SRC=$(readlink ${SRC})
    done
    echo $(dirname $SRC)
}

ROOT=$(GetPrefix $0)
. ${ROOT}/funcs.sh

[[ $# -eq 0 ]] &&  UsageExit

GetOpts $@

if [[ -f ${PROFILE}/params.sh ]]
    then
	. ${PROFILE}/params.sh
    else
	echo Profile ${PROFILE}/params.sh not found!
	exit 5
fi

PrintStatus

case $COMMAND in
    status)
	DoStatus
	;;
    set-default)
	DoSetDefault
	;;
    profiles)
	DoListProfiles
	;;
    restart)
	DoRestart
	;;
    start)
	DoStart
	;;
    stop)
	DoStop
	;;
    shell)
	DoShell
	;;
    init)
	DoInit
	;;
    run)
	DoRun
	;;
    build)
	DoBuild
	;;
    *) 
	echo "Invalid command $COMMAND"
	UsageExit
	;;
esac





