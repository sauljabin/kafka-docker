keytool=docker run -it --rm -v kafka_certificates:/certs -w /certs --network host openjdk:8-jre keytool
openssl=docker run -it --rm -v kafka_certificates:/certs -w /certs --network host openjdk:8-jre openssl
bash=docker run -it --rm --entrypoint /bin/bash --network host

topic=default
pass=123456

build:
	@ docker build -t kafka .

run: build
	@ docker stack deploy -c docker-compose.yml kafka

run-secure: build
	@ docker stack deploy -c docker-compose.secure.yml kafka

status:
	@ docker stack ps kafka

stop:
	@ docker stack rm kafka

log-kafka:
	@ docker service logs -f kafka_kafka

log-zookeeper:
	@ docker service logs -f kafka_zookeeper

bash-kafka:
	@ $(bash) -v kafka_data:/data -v kafka_logs:/kafka/logs -v kafka_certificates:/certs kafka

bash-zookeeper:
	@ $(bash) -v zookeeper_data:/data -v zookeeper_datalog:/datalog -v zookeeper_logs:/logs zookeeper:3.4

create-topic:
	@ $(bash) kafka bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic $(topic)

list-topic:
	@ $(bash) kafka	bin/kafka-topics.sh --list --zookeeper localhost:2181

console-producer:
	@ $(bash) kafka bin/kafka-console-producer.sh --broker-list localhost:9093 --topic $(topic)

console-consumer:
	@ $(bash) kafka bin/kafka-console-consumer.sh --bootstrap-server localhost:9093 --topic $(topic) --from-beginning

generate-ca-cert:
	@ docker volume create kafka_certificates
	@ $(openssl) req -new -newkey rsa:4096 -days 365 -x509 -subj "/CN=Kafka-Security-CA" -keyout ca-key -out ca-cert -nodes

print-ca-cert:
	@ $(keytool) -printcert -v -file ca-cert

generate-keystore:
	@ $(keytool) -genkey -keystore kafka.server.keystore.jks -validity 365 -storepass $(pass) -keypass $(pass) -dname "CN=localhost" -storetype pkcs12

print-keystore:
	@ $(keytool) -list -v -keystore kafka.server.keystore.jks

generate-signed-cert:
	@ $(keytool) -keystore kafka.server.keystore.jks -certreq -file cert-file -storepass $(pass) -keypass $(pass)
	@ $(openssl) x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:$(pass)

print-signed-cert:
	@ $(keytool) -printcert -v -file cert-signed

generate-truststore:
	@ $(keytool) -keystore kafka.server.truststore.jks -alias CARoot -import -file ca-cert -storepass $(pass) -keypass $(pass) -noprompt

print-truststore:
	@ $(keytool) -list -v -keystore kafka.server.truststore.jks

import-ca-certs:
	@ $(keytool) -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert -storepass $(pass) -keypass $(pass) -noprompt
	@ $(keytool) -keystore kafka.server.keystore.jks -import -file cert-signed -storepass $(pass) -keypass $(pass) -noprompt

bash-certs:
	@ $(bash) -v kafka_certificates:/certs -w /certs openjdk:8-jre

test-secure-connection:
	@ $(openssl) s_client -connect localhost:9093

generate-all-certificates: generate-ca-cert generate-keystore generate-signed-cert generate-truststore import-ca-certs
