FROM openjdk:11-jre

LABEL maintainer="sauljabin@gmail.com"

ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 3.0.0
ENV KAFKA_URL "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
ENV KAFKA_HOME /kafka
ENV KAFKA_BIN ${KAFKA_HOME}/bin

ENV ZOE_VERSION=0.27.2
ENV ZOE_URL "https://github.com/adevinta/zoe/releases/download/v${ZOE_VERSION}/zoe-${ZOE_VERSION}.tar"
ENV ZOE_HOME /zoe
ENV ZOE_BIN ${ZOE_HOME}/bin

ENV PATH $PATH:${KAFKA_BIN}:${ZOE_BIN}

RUN apt-get update && \
    apt-get install -y wget kafkacat vim jq httpie curl

RUN wget -q "${ZOE_URL}" -O /tmp/zoe.tar && \
    mkdir ${ZOE_HOME} && \
    tar fx /tmp/zoe.tar --strip-components 1 -C ${ZOE_HOME} && \
    rm /tmp/zoe.tar

RUN wget -q "${KAFKA_URL}" -O /tmp/kafka.tgz && \
    mkdir ${KAFKA_HOME} && \
    tar xfz /tmp/kafka.tgz --strip-components 1 -C ${KAFKA_HOME} && \
    rm /tmp/kafka.tgz

RUN for i in ${KAFKA_BIN}/*.sh; do ln -s "$i" "${i%.sh}"; done
RUN ln -s ${KAFKA_BIN}/kafka-server-start.sh ${KAFKA_BIN}/kafka
RUN ln -s ${KAFKA_BIN}/zookeeper-server-start.sh ${KAFKA_BIN}/zookeeper

COPY server.properties ${KAFKA_HOME}/config
COPY zookeeper.properties ${KAFKA_HOME}/config
COPY zoe.yml ${ZOE_HOME}/config/default.yml

WORKDIR ${KAFKA_HOME}
