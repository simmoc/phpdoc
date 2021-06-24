FROM openjdk:8-jdk
ENV LOGPUSH_VERSION 0.5.8.0
RUN mkdir -p /var/fiery /var/fiery/logs /var/fiery/index /var/fiery/db
COPY ./config/logpusher.properties  /var/fiery/logpusher.properties
COPY ./fiery-logpusher-$LOGPUSH_VERSION.jar /var/fiery/client/fiery-logpusher-$LOGPUSH_VERSION.jar
CMD nohup java -XX:-MaxFDLimit -Xms128m -Xmx450m -XX:ReservedCodeCacheSize=240m -XX:+UseCompressedOops -jar /var/fiery/fiery-logpusher-$LOGPUSH_VERSION.jar -c /var/fiery/logpusher.properties &
