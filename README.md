# kafka-docker

## Tech Stack

- [zookeeper](https://hub.docker.com/_/zookeeper) v3.14
- [kafka](https://kafka.apache.org/quickstart) v2.12-2.1.1

## Comandos Locales

#### Inicializa la network y volumes de docker:
```
$ make init
```

> Red: `broker_network`

> Datos: `zookeeper_data`, `zookeeper_datalog`, `broker_data`

> Logs:`zookeeper_logs`, `broker_logs`

#### Construye la imagen de docker `broker`:
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
$ make log-broker
```

#### Muestra los logs de zookeeper:
```
$ make log-zookeeper
```

#### Crea una instancia del broker y abre un terminal:
```
$ make bash-broker
```

#### Crea una instancia de zookeeper y abre un terminal:
```
$ make bash-zookeeper
```

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
