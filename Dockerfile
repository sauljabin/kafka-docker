FROM openjdk:8-jre
ARG SCALA_VERSION
ARG KAFKA_VERSION
ENV SCALA_VERSION ${SCALA_VERSION}
ENV KAFKA_VERSION ${KAFKA_VERSION}
WORKDIR /kafka
RUN wget -q https://www-us.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -O /tmp/kafka.tgz && \
    tar xfz /tmp/kafka.tgz --strip-components 1 && \
    rm /tmp/kafka.tgz
ENTRYPOINT ["bin/kafka-server-start.sh", "config/server.properties"]
