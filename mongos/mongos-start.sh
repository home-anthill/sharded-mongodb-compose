#!/bin/sh

# Invoke script for stuff extra to the generic MongoDB docker image entrypoint
/usr/local/bin/mongos-runextra.sh &

# Run DockerHub's "official image" entrypoint now
exec /usr/local/bin/docker-entrypoint.sh "$@"
