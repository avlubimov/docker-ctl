#!/bin/bash


ID=`docker ps -a --filter name=${CONTAINER} --format "{{.ID}}" `

if [[ ! -z "${ID}" ]]; then
  echo  container ${CONTAINER} exists! Force to remove it 
  docker rm -f ${CONTAINER}
fi


docker run -dt  \
   --ulimit nofile=1024:1024 \
   --net host \
   --privileged \
   -v /var/run/dbus:/var/run/dbus \
   -v /dev/bus/usb:/dev/bus/usb \
   -v ${CONFDIR}:/etc/cups/ \
   -v ${LOGSDIR}:/var/log/cups \
  --name ${CONTAINER} \
  ${IMAGE}

# --restart unless-stopped 
# without option --ulimit nofile=1024:1024  got error in error_log
# [19/Dec/2023:08:36:45 +0000] cupsdDoSelect() failed - Bad address!
# [19/Dec/2023:08:36:45 +0000] Listeners[0] = 6
# [19/Dec/2023:08:36:45 +0000] Listeners[1] = 7
# [19/Dec/2023:08:36:45 +0000] Listeners[2] = 8
# [19/Dec/2023:08:36:45 +0000] CGIPipes[0] = 9
# [19/Dec/2023:08:36:45 +0000] Scheduler shutting down due to program error.
# --restart unless-stopped 
