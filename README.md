# kafka-docker

Kafka Tag `2.12-2.2.1`

Zookeeper Tage `3.4`

## Quick reference

- [Git Hub](https://github.com/sauljabin/kafka-docker)
- [Kafla Docker Hub](https://hub.docker.com/r/sauljabin/kafka)
- [Zookeeper Docker Hub](https://hub.docker.com/_/zookeeper)

## Documentation

- [Kafka](https://kafka.apache.org)
- [Zookeeper](https://zookeeper.apache.org)

## Getting Started

```
$ docker swarm init
$ make build run
```

## Default Ports

| Port | Description |
| - | - |
| 2181 | Zookeeper port |
| 9092 | Internal Kafka port |
| 9093 | External Kafka port |

## Docker Stack Examples

- [docker-compose.yml](docker-compose.yml)
- [docker-compose.segure.yml](docker-compose.segure.yml)
- [docker-compose.multiple.yml](docker-compose.multiple.yml)

```yaml
version: '3.7'

services:
  zookeeper:
    image: zookeeper:3.4
    environment:
      - TZ=America/Guayaquil
      - ZOO_MY_ID=1
      - ZOO_SERVERS=server.1=0.0.0.0:2888:3888
      - ZOO_LOG4J_PROP=INFO,ROLLINGFILE
    ports:
      - 2181:2181
    volumes:
      - zookeeper_data:/data
      - zookeeper_datalog:/datalog
      - zookeeper_logs:/logs

  kafka:
    image: kafka
    environment:
      - TZ=America/Guayaquil
    ports:
      - 9093:9093
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
    command: >
      --override broker.id=1
      --override log.dirs=/data
      --override zookeeper.connect=zookeeper:2181
      --override listener.security.protocol.map=INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT
      --override inter.broker.listener.name=INTERNAL
      --override listeners=INTERNAL://0.0.0.0:9092,EXTERNAL://0.0.0.0:9093
      --override advertised.listeners=INTERNAL://kafka:9092,EXTERNAL://localhost:9093

volumes:
  kafka_data:
  kafka_logs:
  zookeeper_data:
  zookeeper_logs:
  zookeeper_datalog:
```

## Using from Docker Hub

Image: `sauljabin/kafka`.

```bash
$ docker pull sauljabin/kafka
```

Stack:

```yaml
version: '3.7'

services:
  kafka:
    image: sauljabin/kafka
```

## Make Commands

#### Builds the docker image: `kafka:latest`
```
$ make build
```

#### Deploys a kafka broker
```
$ make run
```

#### Shows the stack status
```
$ make status
```

#### Stops stack
```
$ make stop
```

## Commands for Kafka

#### Creates a topic
```
$ make create-topic topic=test
```

#### Muestra la lista de tópicos
```
$ make topic-list
```

#### Creates a console producer connection
```
$ make console-producer topic=test
```

#### Creates a console consumer connection
```
$ make console-consumer topic=test
```

## Kafka/SSL

#### Generates the key store files and creates a `kafka_certificates` volume
```
$ generate-all-certificates
```

#### Deploys kafka using SSL
```
$ make run-secure
```

#### Creates a console producer with SSL connection
```
$ make console-producer-secure topic=test
```

#### Creates a console consumer with SSL connection
```
$ make console-consumer-secure topic=test
```

## Run a kafka cluster example

#### Deploys kafka cluster
```
$ make run-multiple
```

#### Creates a topic
```
$ make create-topic-multiple topic=test
```

#### Creates a console consumer for the cluster
```
$ make console-consumer-multiple topic=test group=test
```
