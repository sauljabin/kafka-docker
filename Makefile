build:
	@ docker build -t kafka -f Dockerfile.kafka .

run: build
	@ docker stack deploy -c docker-compose.yml kafka

status:
	@ docker stack ps kafka

stop:
	@ docker stack rm kafka

log-kafka:
	@ docker service logs -f kafka_kafka

log-zookeeper:
	@ docker service logs -f kafka_zookeeper

bash-kafka:
	@ docker run -it --rm --entrypoint /bin/bash \
	-v kafka_data:/data -v kafka_logs:/kafka/logs \
	kafka

bash-zookeeper:
	@ docker run -it --rm --entrypoint /bin/bash -v zookeeper_data:/data \
	-v zookeeper_datalog:/datalog -v zookeeper_logs:/logs \
	zookeeper:3.4

topic=default

create-topic:
	@ docker run -it --rm --entrypoint /bin/bash --network host kafka \
	bin/kafka-topics.sh --create --zookeeper localhost:2181 \
	--replication-factor 1 --partitions 1 --topic $(topic)

list-topic:
	@ docker run -it --rm --entrypoint /bin/bash --network host kafka \
	bin/kafka-topics.sh --list --zookeeper localhost:2181

console-producer:
	@ docker run -it --rm --entrypoint /bin/bash --network host kafka \
	bin/kafka-console-producer.sh --broker-list localhost:9093 \
	--topic $(topic)

console-consumer:
	@ docker run -it --rm --entrypoint /bin/bash --network host kafka \
	bin/kafka-console-consumer.sh --bootstrap-server localhost:9093 \
	--topic $(topic) --from-beginning

generate-cert:
	@ docker build -t openssl -f Dockerfile.openssl .
	@ docker volume create kafka_certificates
	@ docker run -it --rm -v kafka_certificates:/certs openssl req -new -newkey rsa:4096 -days 365 \
	-x509 -subj "/CN=Kafka-Security-CA" -keyout ca-key -out ca-cert -nodes
