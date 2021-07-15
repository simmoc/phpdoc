FROM debian:stretch

COPY ./config/apt_source.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get install apt-utils -y && \
    apt-get upgrade -y && \
    apt-get install nginx -y && \
    apt-get install mariadb-server -y && \
    apt-get install redis-server -y && \
    apt-get install mongodb -y && \
    apt-get install beanstalkd -y && \
    apt-get install php7.4-fpm -y && \
    apt-get install php7.4-redis -y && \
    apt-get install php7.4-curl -y && \
    apt-get install php7.4-mysql -y && \
    apt-get install php7.4-mongodb -y && \
    apt-get install php7.4-xml -y && \
    apt-get install php7.4-mbstring -y && \
    apt-get install php7.4-yaml -y && \
    apt-get install php7.4-dev -y && \
    apt-get install php7.4-zip -y && \
    apt-get install php7.4-gd -y && \
    apt-get install phpunit -y && \
    apt-get install inotify-tools -y && \
    apt-get install wget -y && \
    apt-get install gnupg -y && \
    apt-get install zip -y && \
    apt-get install git -y && \
    apt-get install composer -y && \
    apt-get install vim -y && \
    apt-get install tmux -y && \
    apt-get install tmuxinator -y && \
    apt-get install supervisor -y && \
    apt-get install toilet -y && \
    apt-get install python3-pip -y && \
    pip install mycli
RUN  apt-get install openjdk-8-jdk -y &&\
     apt-get install php-bcmath -y
COPY ./shell/start.sh /bin/start
RUN chown root:root /bin/start && \
    chmod +x /bin/start

COPY ./config/bashrc /root/.bashrc
COPY ./config/tmux.conf /root/.tmux.conf

RUN mkdir -p /root/.tmuxinator
COPY ./config/tmuxinator_init.yml /root/.tmuxinator/init.yml

RUN mkdir -p /var/fiery /var/fiery/logs /var/fiery/index /var/fiery/db
COPY ./config/logpusher.properties  /var/fiery/logpusher.properties
COPY ./fiery/fiery-logpusher-0.5.8.0.jar /var/fiery/fiery-logpusher.jar
COPY ./fiery/fiery-server-0.5.8.0.jar /var/fiery/fiery-server.jar
COPY ./config/fiery_fastcgi_params /etc/nginx/fiery_fastcgi_params


COPY ./shell/config_init.sh /tmp/config_init.sh
RUN /bin/bash /tmp/config_init.sh

RUN touch /tmp/php_exception.log && \
    touch /tmp/php_notice.log && \
    touch /tmp/php_module.log && \
    chown www-data:www-data /tmp/php_exception.log && \
    chown www-data:www-data /tmp/php_notice.log && \
    chown www-data:www-data /tmp/php_module.log

ENV LC_ALL C.UTF-8
EXPOSE 80 3306 9090
CMD start
