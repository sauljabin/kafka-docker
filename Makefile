build:
	@ docker build -t broker .

run: build
	@ docker stack deploy --with-registry-auth -c docker-compose.yml broker

init:
	@ docker network create --driver overlay --scope swarm broker_network  || true
	@ docker volume create zookeeper_data || true
	@ docker volume create zookeeper_datalog || true
	@ docker volume create zookeeper_logs || true
	@ docker volume create broker_data || true
	@ docker volume create broker_logs || true

status:
	@ docker stack ps broker

stop:
	@ docker stack rm broker

log-broker:
	@ docker service logs -f broker_broker

log-zookeeper:
	@ docker service logs -f broker_zookeeper

bash-broker:
	@ docker run -it --rm --entrypoint /bin/bash \
	-v broker_data:/data -v broker_logs:/kafka/logs \
	broker

bash-zookeeper:
	@ docker run -it --rm --entrypoint /bin/bash -v zookeeper_data:/data \
	-v zookeeper_datalog:/datalog -v zookeeper_logs:/logs \
	zookeeper:3.4

topic=default

create-topic:
	@ docker run -it --rm --entrypoint /bin/bash --network host broker \
	bin/kafka-topics.sh --create --zookeeper localhost:2181 \
	--replication-factor 1 --partitions 1 --topic $(topic)

list-topic:
	@ docker run -it --rm --entrypoint /bin/bash --network host broker \
	bin/kafka-topics.sh --list --zookeeper localhost:2181

console-producer:
	@ docker run -it --rm --entrypoint /bin/bash --network host broker \
	bin/kafka-console-producer.sh --broker-list localhost:9093 \
	--topic $(topic)

console-consumer:
	@ docker run -it --rm --entrypoint /bin/bash --network host broker \
	bin/kafka-console-consumer.sh --bootstrap-server localhost:9093 \
	--topic $(topic) --from-beginning
