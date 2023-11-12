# kafka-docker

<a href="https://www.docker.com/"><img alt="Docker" src="https://img.shields.io/badge/-docker-blue?logo=docker&logoColor=white"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://img.shields.io/badge/status-active-brightgreen"></a>
<a href="https://github.com/sauljabin/kafka-docker/blob/main/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/sauljabin/kafka-docker"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/sauljabin/kafka"></a>
<a href="https://hub.docker.com/r/sauljabin/kafka"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/sauljabin/kafka"></a>

This projects allows you to deploy a Kafka using KRaft.

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

Run a sandbox:
```sh
docker compose -p kafka up -d
docker compose -p kafka down
```

> For generating a new cluster id run: `kafka-storage random-uuid` and set `CLUSTER_ID` env variable.

Run `jsonsole`:
```
jconsole localhost:19095
```

## Usage

> Install kafka cli tools using https://github.com/sauljabin/kafka-cli-installer.

Create a topic:
```sh
kafka-topics --create --bootstrap-server localhost:19092 --topic customers
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
| 9092 | Internal Kafka Port |
| 9094 | Controller Kafka Port |
| 19092, 29092, 39092 | External Kafka Ports |
| 19095, 29095, 39095 | JMX Ports |

## Development

Build image locally:
```sh
docker build -t sauljabin/kafka:latest .
```

Run a shell:
```sh
docker run --rm -it sauljabin/kafka:latest bash
```

Run a single node:
```sh
docker run -d -p 9092:9092 --name kafka sauljabin/kafka:latest
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
