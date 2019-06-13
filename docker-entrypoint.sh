#!/usr/bin/env bash

set -Eeo pipefail

echo "Kafka Docker Documentation https://hub.docker.com/r/sauljabin/kafka"

if [[ "$1" == "--override" ]]; then
    exec "kafka" "config/server.properties" "$@"
else
    exec "$@"
fi
