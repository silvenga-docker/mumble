#!/bin/sh

set -x

DEFAULT_CONFIG=/etc/murmur.ini
CUSTOM_CONFIG=/data/mumble.ini
CONFIG=${DEFAULT_CONFIG}

if [ -f "${CUSTOM_CONFIG}" ]; then
    CONFIG=${CUSTOM_CONFIG}
else
    echo "${CUSTOM_CONFIG} not found, using default configuration file."
fi

echo "Using ${CONFIG} for Mumble options."

echo "Overriding option: database -> /data/murmur.sqlite."
crudini --set ${CONFIG} "" database /data/murmur.sqlite
echo "Overriding option: logfile -> stdout."
crudini --set ${CONFIG} "" logfile

echo "Updating permissions on /data."
mkdir -p /data
chown murmur:murmur -R /data

# murmurd -ini ${CONFIG} -supw password

echo "Starting Mumble."
/usr/bin/murmurd -ini "${CONFIG}" -fg