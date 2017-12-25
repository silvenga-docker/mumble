#!/bin/sh

DEFAULT_CONFIG=/etc/murmur.ini
CUSTOM_CONFIG=/data/mumble.ini
WORKING_CONFIG=/etc/murmur-working.ini
CONFIG=${DEFAULT_CONFIG}

if [ -f "${CUSTOM_CONFIG}" ]; then
    CONFIG=${CUSTOM_CONFIG}
else
    echo "${CUSTOM_CONFIG} not found, using default configuration file."
fi

echo "Copying ${CONFIG} to working area ${WORKING_CONFIG}."
cp ${CONFIG} ${WORKING_CONFIG}

echo "Using ${WORKING_CONFIG} for Mumble options."

echo "Overriding option: database -> /data/murmur.sqlite."
crudini --set ${WORKING_CONFIG} "" database /data/murmur.sqlite
echo "Overriding option: logfile -> stdout."
crudini --set ${WORKING_CONFIG} "" logfile
echo "Overriding option: uname -> murmur."
crudini --set ${WORKING_CONFIG} "" uname murmur
echo "Overriding option: bonjour -> False."
crudini --set ${WORKING_CONFIG} "" bonjour False

echo "Updating permissions on /data."
mkdir -p /data
chown murmur:murmur -R /data

# murmurd -ini ${WORKING_CONFIG} -supw password

echo "Starting Mumble."
/usr/bin/murmurd -ini "${WORKING_CONFIG}" -fg