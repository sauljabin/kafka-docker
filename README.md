# kafka-docker

<a href="https://www.docker.com/"><img alt="Docker" src="https://img.shields.io/badge/-docker-blue?logo=docker&logoColor=white"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://img.shields.io/badge/status-active-brightgreen"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://badges.pufler.dev/updated/sauljabin/kafka-docker?label=updated"></a>
<a href="https://github.com/sauljabin/kafka-docker/blob/main/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/sauljabin/kafka-docker"></a>
<a href="https://github.com/sauljabin/kafka-docker/actions/workflows/main.yml"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/sauljabin/kafka-docker/CI%20to%20Docker%20Hub"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/sauljabin/kafka"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/sauljabin/kafka"></a>

- kafka `3.0.0`
- docker tags: `sauljabin/kafka:3.0.0`, `sauljabin/kafka:latest`

## Quick reference

- [github](https://github.com/sauljabin/kafka-docker)
- [dockerhub](https://hub.docker.com/r/sauljabin/kafka)
- [kafka](https://kafka.apache.org)
- [zookeeper](https://zookeeper.apache.org)
- [kafkacat](https://github.com/edenhill/kafkacat)
- [zoe](https://github.com/adevinta/zoe)

## Getting Started

Check the [docker-compose.yml](docker-compose.yml) file.
```sh
docker compose up -d
docker compose down
```

## Building Locally (for development)

Pulling:
```sh
docker build -t sauljabin/kafka:latest .
```

## Default Ports

| Port | Description |
| - | - |
| 2181 | Zookeeper port |
| 9092 | Internal Kafka port |
| 9093 | External Kafka port |

## Volumes

You could change the properties path adding a volume to `/kafka/config` path.

Zookeeper `config/zookeeper.properties`:
```yaml
    volumes:
      - zookeeper_data:/data
      - zookeeper_datalog:/datalog
      - zookeeper_logs:/kafka/logs
      - zookeeper_config:/kafka/config
```

Kafka `config/server.properties`:
```yaml
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
      - kafka_config:/kafka/config
```

For zoe configuration `/zoe/config/default.yml`.
```yaml
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
      - kafka_config:/kafka/config
      - ./zoe.yml:/zoe/config/default.yml
```

## Commands

Open a command line in the container:
```sh
docker compose exec kafka bash
```

Create a topic:
```sh
docker compose exec kafka kafka-topics.sh --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic customers
```

Topic list:
```sh
docker compose exec kafka kafka-topics.sh --list --bootstrap-server kafka:9092
```

Console producer:
```sh
cat customers.txt | docker compose exec -T kafka kafka-console-producer.sh --broker-list kafka:9092 --topic customers
```

Console consumer:
```sh
docker compose exec kafka kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic customers --from-beginning
```

Consuming using zoe:
```sh
docker compose exec kafka zoe --output table topics consume customers
```

Consuming using kafkacat:
```sh
docker compose exec kafka kafkacat -b kafka:9092 -t customers
```
