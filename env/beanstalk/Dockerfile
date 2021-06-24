FROM schickling/beanstalkd
# set timezome
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./node_expoter/node_exporter /usr/local/bin/
EXPOSE 9090
