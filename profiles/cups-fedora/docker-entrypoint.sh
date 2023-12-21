#!/bin/bash

FILE=/etc/cups/cupsd.conf
START_CUPS_BROWSED=/etc/cups/START_CUPS_BROWSED

if [[ ! -f "$FILE" ]]; then
    cp -r /srv/cups/* /etc/cups
fi

if [[ -f ${START_CUPS_BROWSED} ]]; then
    /usr/sbin/cupsd
    /usr/sbin/cups-browsed
else
    /usr/sbin/cupsd -f
fi



