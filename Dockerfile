FROM base_v2:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE rabbitmq
ENV SHARE_CONF_DIR /usr/share/docker

RUN echo "lamtv10"

RUN  apt-get -y install rabbitmq-server

RUN echo 'lamtv10'
RUN id -u rabbitmq

RUN cat /etc/group | grep rabbitmq
RUN rm -rf /var/lib/rabbitmq/*
#COPY erlang.cookie /var/lib/rabbitmq/.erlang.cookie
RUN chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

RUN mkdir -p /var/run/rabbitmq   && chmod 777 /var/run/rabbitmq/
RUN ls -l /var/run/
RUN ls -l /var/run/rabbitmq

#RUN rm -rf  /var/run/rabbitmq/

COPY rabbitmq_sudoers /etc/sudoers.d/rabbitmq_sudoers

COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh


EXPOSE 5672 15672

VOLUME [ "/var/lib/rabbitmq/", "/var/log/rabbitmq/" ]

USER root

CMD ["start.sh"]
