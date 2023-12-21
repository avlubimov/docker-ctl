#!/bin/bash

for DIR in ${PREFIX}  ${CONFDIR} ${LOGSDIR} ${DRVDIR} ${BINDIR}
    do 
	[[ ! -d ${DIR} ]] && mkdir -p ${DIR}
    done

