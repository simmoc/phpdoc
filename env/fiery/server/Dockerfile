FROM openjdk:8-jdk
ENV FIERY_VERSION 0.5.8.0
RUN mkdir -p /var/fiery /var/fiery/logs /var/fiery/index /var/fiery/db
COPY ./fiery-server-$FIERY_VERSION.jar /var/fiery/fiery-server-$FIERY_VERSION.jar
RUN nohup java -XX:-MaxFDLimit -Xms3750m -Xmx3750m -XX:ReservedCodeCacheSize=240m -XX:+UseCompressedOops -jar /var/fiery/fiery-server-$FIERY_VERSION.jar --logging.file=/var/fiery/log/application.log  --server.port=9090 --fiery.kafkaenable=false --fiery.keepdataday=30 &


