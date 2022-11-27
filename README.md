# kafka-docker

<a href="https://www.docker.com/"><img alt="Docker" src="https://img.shields.io/badge/-docker-blue?logo=docker&logoColor=white"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://img.shields.io/badge/status-active-brightgreen"></a>
<a href="https://github.com/sauljabin/kafka-docker/blob/main/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/sauljabin/kafka-docker"></a>
<a href="https://github.com/sauljabin/kafka-docker/actions/workflows/main.yml"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/sauljabin/kafka-docker/CI%20to%20Docker%20Hub"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/sauljabin/kafka"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/sauljabin/kafka"></a>

```
docker pull sauljabin/kafka:latest
```

## Quick Reference

- [github](https://github.com/sauljabin/kafka-docker)
- [dockerhub](https://hub.docker.com/r/sauljabin/kafka)

## Software Installed in the Docker Image

- [kafka](https://kafka.apache.org)
- [zookeeper](https://zookeeper.apache.org)

## Getting Started

Run using `zookeeper` [docker-compose.yml](docker-compose.yml) file:
```sh
docker network create kafka
docker compose up -d
docker compose down
```

Run using Kraft [docker-compose.kraft.yml](docker-compose.kraft.yml):
```sh
docker compose -f docker-compose.kraft.yml up -d
docker compose -f docker-compose.kraft.yml down
```

Run `jsonsole`:
```
jconsole localhost:19095
```

## Usage

Create a topic:
```sh
kafka-topics --create --bootstrap-server localhost:19092 --replication-factor 1 --partitions 1 --topic customers
```

Topic list:
```sh
kafka-topics --list --bootstrap-server localhost:19092
```

Console producer:
```sh
echo '{"name": "John Doe", "email": "john.doe@gmail.com"}' | kafka-console-producer --broker-list localhost:19092 --topic customers
echo '{"name": "Jane Doe", "email": "jane.doe@gmail.com"}' | kafka-console-producer --broker-list localhost:19092 --topic customers
```

Console consumer:
```sh
kafka-console-consumer --bootstrap-server localhost:19092 --topic customers --from-beginning
```

## Default Ports

| Port | Description         |
| ---- | ------------------- |
| 2181 | Zookeeper port      |
| 9092 | Internal Kafka port |
| 19092 | External Kafka port |

## Volumes

Zookeeper:
```yaml
    volumes:
      - zookeeper_data:/data
      - zookeeper_datalog:/datalog
      - zookeeper_logs:/kafka/logs
      - ./config/zookeeper/zookeeper.properties:/kafka/config/zookeeper.properties
```

Kafka:
```yaml
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
      - - ./config/zookeeper/kafka.properties:/kafka/config/kafka.properties
```

Kraft:
```yaml
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
      - - ./config/kraft/kafka.properties:/kafka/config/kafka.properties
```

## Development

Build image locally:
```sh
docker build -t sauljabin/kafka:latest .
```

Run a shell:
```sh
docker run --rm -it sauljabin/kafka:latest bash
```

Linters:
```sh
hadolint Dockerfile
yamllint .
```

Pre-commit:
```sh
pre-commit install
```

## Releasing a new version

> Semver info [here](https://semver.org/)

```
git tag major.minor.patch
git push --tags
```
