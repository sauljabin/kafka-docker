FROM openjdk:8-jre

LABEL maintainer="sauljabin@gmail.com"

ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 2.8.0
ENV KAFKA_HOME /kafka
ENV KAFKA_URL https://downloads.apache.org/kafka/2.8.0/kafka_2.13-2.8.0.tgz
ENV KAFKA_BIN ${KAFKA_HOME}/bin
ENV PATH $PATH:${KAFKA_BIN}

WORKDIR ${KAFKA_HOME}

RUN wget -q "${KAFKA_URL}" -O /tmp/kafka.tgz && \
    tar xfz /tmp/kafka.tgz --strip-components 1 && \
    rm /tmp/kafka.tgz

RUN ln -s ${KAFKA_BIN}/kafka-server-start.sh ${KAFKA_BIN}/kafka
RUN ln -s ${KAFKA_BIN}/zookeeper-server-start.sh ${KAFKA_BIN}/zookeeper

COPY server.properties ${KAFKA_HOME}/config
COPY zookeeper.properties ${KAFKA_HOME}/config
