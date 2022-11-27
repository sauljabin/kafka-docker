#!/bin/bash

if [[ "$1" == "zookeeper" ]]; then
	zookeeper-server-start config/zookeeper.properties
elif [[ "$1" == "kafka-raft" ]]; then
	rm -f /data/__cluster_metadata-0/quorum-state
	kafka-storage format --ignore-formatted --config config/kafka.properties --cluster-id "$CLUSTER_ID"
	kafka-server-start config/kafka.properties
elif [[ "$1" == "kafka" ]]; then
	kafka-server-start config/kafka.properties
else
	exec "$@"
fi
