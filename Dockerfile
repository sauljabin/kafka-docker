FROM openjdk:8-jre

LABEL maintainer="sauljabin@gmail.com"

ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.2.1
ENV KAFKA_HOME /kafka
ENV KAFKA_BIN $KAFKA_HOME/bin
ENV PATH $PATH:$KAFKA_BIN

WORKDIR $KAFKA_HOME

RUN wget -q "https://www-us.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz" -O /tmp/kafka.tgz && \
    tar xfz /tmp/kafka.tgz --strip-components 1 && \
    rm /tmp/kafka.tgz
RUN ln -s $KAFKA_BIN/kafka-server-start.sh $KAFKA_BIN/kafka

COPY docker-entrypoint.sh $KAFKA_HOME
COPY server.properties $KAFKA_HOME/config

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["kafka", "config/server.properties"]
