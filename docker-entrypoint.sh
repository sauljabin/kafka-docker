#!/bin/bash

if [[ "$1" == "zookeeper" ]]; then
	zookeeper-server-start config/zookeeper.properties
elif [[ "$1" == "kafka-raft" ]]; then
	kafka-storage format --ignore-formatted --config config/kafka.properties --cluster-id "$(kafka-storage random-uuid)"
	kafka-server-start config/kafka.properties
elif [[ "$1" == "kafka" ]]; then
	kafka-server-start config/kafka.properties
else
	exec "$@"
fi
