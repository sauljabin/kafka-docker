FROM alpine:edge

LABEL maintainer="sauljabin@gmail.com"

ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 3.3.1
ENV KAFKA_URL "https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
ENV KAFKA_HOME /kafka
ENV KAFKA_BIN ${KAFKA_HOME}/bin
ENV PATH $PATH:${KAFKA_BIN}

WORKDIR ${KAFKA_HOME}

RUN apk update \
    && apk add --no-cache --upgrade wget bash openjdk17 \
    && wget -q "${KAFKA_URL}" -O /tmp/kafka.tgz \
    && tar -xzf /tmp/kafka.tgz --strip-components 1 -C ${KAFKA_HOME} \
    && rm /tmp/kafka.tgz \
    && for i in "${KAFKA_BIN}"/*.sh; do ln -s "$i" "${i%.sh}"; done

COPY ./docker-entrypoint.sh ${KAFKA_BIN}/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD [ "kafka" ]
