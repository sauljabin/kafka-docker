FROM openjdk:11-jre

LABEL maintainer="sauljabin@gmail.com"

ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 3.2.0
ENV KAFKA_URL "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
ENV KAFKA_HOME /kafka
ENV KAFKA_BIN ${KAFKA_HOME}/bin

ENV ZOE_VERSION=0.27.2
ENV ZOE_URL "https://github.com/adevinta/zoe/releases/download/v${ZOE_VERSION}/zoe-${ZOE_VERSION}.tar"
ENV ZOE_HOME /zoe
ENV ZOE_BIN ${ZOE_HOME}/bin

ENV PATH $PATH:${KAFKA_BIN}:${ZOE_BIN}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        kafkacat \
        vim \
        httpie \
        curl \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "${ZOE_URL}" -O /tmp/zoe.tar \
    && mkdir ${ZOE_HOME} \
    && tar xf /tmp/zoe.tar --strip-components 1 -C ${ZOE_HOME} \
    && rm /tmp/zoe.tar \
    && wget -q "${KAFKA_URL}" -O /tmp/kafka.tgz \
    && mkdir ${KAFKA_HOME} \
    && tar xfz /tmp/kafka.tgz --strip-components 1 -C ${KAFKA_HOME} \
    && rm /tmp/kafka.tgz \
    && for i in "${KAFKA_BIN}"/*.sh; do ln -s "$i" "${i%.sh}"; done \
    && ln -s ${KAFKA_BIN}/kafka-server-start.sh ${KAFKA_BIN}/kafka \
    && ln -s ${KAFKA_BIN}/zookeeper-server-start.sh ${KAFKA_BIN}/zookeeper

COPY server.properties ${KAFKA_HOME}/config
COPY zookeeper.properties ${KAFKA_HOME}/config
COPY zoe.yml ${ZOE_HOME}/config/default.yml

WORKDIR ${KAFKA_HOME}
