FROM openjdk:8-jre
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.1.1
WORKDIR /kafka
RUN wget -q https://www-us.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -O /tmp/kafka.tgz && \
    tar xfz /tmp/kafka.tgz --strip-components 1 && \
    rm /tmp/kafka.tgz
ENTRYPOINT ["bin/kafka-server-start.sh", "config/server.properties"]
