# kafka-docker

Kafka Tag `2.8`

## Quick reference

- [Git Hub](https://github.com/sauljabin/kafka-docker)
- [Kafka](https://kafka.apache.org)
- [Zookeeper](https://zookeeper.apache.org)

## Getting Started

Check the [docker-compose.yml](docker-compose.yml) file.

```
$ docker-compose -p kafka up
```

## Default Ports

| Port | Description |
| - | - |
| 2181 | Zookeeper port |
| 9092 | Internal Kafka port |
| 9093 | External Kafka port |

## Volumes

You could change the properties path adding a volume to `/kafka/config` (`config/zookeeper.properties` and `config/server.properties`) path.

## Commands

#### Open a command line in the container
```
$ docker-compose -p kafka exec kafka bash
```

#### Create a topic:
```
$ docker-compose -p kafka exec kafka kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic test
```

#### Topic list:
```
$ docker-compose -p kafka exec kafka kafka-topics.sh --list --zookeeper zookeeper:2181
```

#### Console producer:
```
$ docker-compose -p kafka exec kafka kafka-console-producer.sh --broker-list kafka:9093 --topic test
```

#### Console consumer:
```
$ docker-compose -p kafka exec kafka kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic test --from-beginning
```
