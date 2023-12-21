#!/bin/bash

for DIR in ${PREFIX}  ${CONFDIR} ${LOGSDIR} 
    do 
	[[ ! -d ${DIR} ]] && mkdir -p ${DIR}
    done

