# kafka-docker

<a href="https://www.docker.com/"><img alt="Docker" src="https://img.shields.io/badge/-docker-blue?logo=docker&logoColor=white"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://img.shields.io/badge/status-active-brightgreen"></a>
<a href="https://github.com/sauljabin/kafka-docker"><img alt="GitHub" src="https://badges.pufler.dev/updated/sauljabin/kafka-docker?label=updated"></a>
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
- [kafkacat](https://github.com/edenhill/kafkacat)
- [zoe](https://github.com/adevinta/zoe)
- [jq](https://stedolan.github.io/jq/)
- [httpie](https://httpie.org/)

## Getting Started

Check the [docker-compose.yml](docker-compose.yml) file.
```sh
docker network create kafka
docker compose up -d
docker compose down
```

## Usage

Create an alias for `kafka-cli`:
```bash
alias kafka-cli='docker run --rm -it --network kafka sauljabin/kafka:latest '
```

To permanently add the alias to your shell (`~/.bashrc` or `~/.zshrc` file):
```bash
echo "alias kafka-cli='docker run --rm -it --network kafka sauljabin/kafka:latest '" >> ~/.zshrc
```

Open a command line in the container:
```sh
kafka-cli
```

Create a topic:
```sh
kafka-cli kafka-topics --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic customers
```

Topic list:
```sh
kafka-cli kafka-topics --list --bootstrap-server kafka:9092
```

Console producer:
```sh
kafka-cli bash -c "echo '"'{"name": "John Doe", "email": "john.doe@gmail.com"}'"' | kafka-console-producer --broker-list kafka:9092 --topic customers"
kafka-cli bash -c "echo '"'{"name": "Jane Doe", "email": "jane.doe@gmail.com"}'"' | kafka-console-producer --broker-list kafka:9092 --topic customers"
```

Console consumer:
```sh
kafka-cli kafka-console-consumer --bootstrap-server kafka:9092 --topic customers --from-beginning
```

Consuming using zoe:
```sh
kafka-cli zoe --output table topics consume customers
```

Consuming using kafkacat:
```sh
kafka-cli kafkacat -b kafka:9092 -t customers
```

## Default Ports

| Port | Description         |
| ---- | ------------------- |
| 2181 | Zookeeper port      |
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

Zoe configuration `/zoe/config/default.yml`.
```yaml
    volumes:
      - kafka_data:/data
      - kafka_logs:/kafka/logs
      - kafka_config:/kafka/config
      - ./zoe.yml:/zoe/config/default.yml
```

## Development

Build image locally:
```sh
docker build -t sauljabin/kafka:latest .
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
