# kafka-docker

## Tech Stack

- [zookeeper](https://hub.docker.com/_/zookeeper) v3.14
- [kafka](https://kafka.apache.org/quickstart) v2.12-2.2.0

## Links

- https://github.com/31z4/zookeeper-docker
- https://hub.docker.com/_/zookeeper
- https://docs.confluent.io/2.0.0/kafka/ssl.html

## Comandos Docker

#### Construye la imagen de docker `kafka:latest`:
```
$ make build
```

#### Despliegua broker en docker swarm:
```
$ make run
```

#### Muestra la información del stack:
```
$ make status
```

#### Detiene los servicios:
```
$ make stop
```

#### Muestra los logs del broker:
```
$ make log-kafka
```

#### Muestra los logs de zookeeper:
```
$ make log-zookeeper
```

#### Crea una instancia del broker y abre un terminal:
```
$ make bash-kafka
```

#### Crea una instancia de zookeeper y abre un terminal:
```
$ make bash-zookeeper
```

## Comandos Kafka

#### Crea un tópico de prueba (`default`):
```
$ make create-topic
```

#### Crea un tópico:
```
$ make create-topic topic=test
```

#### Muestra la lista de tópicos:
```
$ make list-topic
```

#### Ejemplo de productor (tópico `default`):
```
$ make console-producer
```

#### Ejemplo de productor:
```
$ make console-producer topic=test
```

#### Ejemplo de consumidor (tópico `default`):
```
$ make console-consumer
```

#### Ejemplo de consumidor:
```
$ make console-consumer topic=test
```

## Comandos Kafka/SSL

#### Genera los certificados y los keystore para la configuración de seguridad, crea el volume `kafka_certificates`:
```
$ generate-all-certificates
```

#### Despliega el broker seguro:
```
$ make run-secure
```

#### Abre un terminal para manipular los certificados:
```
$ make bash-certs
```

#### Ejemplo de productor (tópico `default`):
```
$ make console-producer-secure
```

#### Ejemplo de productor:
```
$ make console-producer-secure topic=test
```

#### Ejemplo de consumidor (tópico `default`):
```
$ make console-consumer-secure
```

#### Ejemplo de consumidor:
```
$ make console-consumer-secure topic=test
```
