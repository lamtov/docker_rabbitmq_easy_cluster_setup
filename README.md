
![Docker Image CI](https://github.com/lamto20132223/Docker_RabbitMq_Easy_Cluster/workflows/Docker%20Image%20CI/badge.svg?branch=master)
# RabbitMQ Server Easy Cluster Setup

[RabbitMQ](https://rabbitmq.com) is a [feature rich](https://rabbitmq.com/documentation.html), multi-protocol messaging broker. It supports:

 * AMQP 0-9-1
 * AMQP 1.0
 * MQTT 3.1.1
 * STOMP 1.0 through 1.2
 * RABBITMQ 

This image will help you build Rabbitq Cluster easyly

> Link to DockerHub: https://hub.docker.com/r/tovanlam/rabbitmq


## Installation

 * First create docker volume in host you want to setup: 
 ```bash
	rm -rf /usr/share/docker/rabbitmq/rabbitmq/
	rm -rf /u01/docker/docker_log/rabbitmq/
	rm -rf  /var/lib/rabbitmq
	mkdir -p /u01/docker/docker_log/rabbitmq/
	mkdir  -p  /usr/share/docker/rabbitmq/rabbitmq/rabbitmq-data/
```
 * Second create Earlang.cookie for this Cluster:
 ```bash
	echo  "VZDYBEEEQDCBCHSKENTY" > /usr/share/docker/rabbitmq/rabbitmq/.erlang.cookie 
	chown -R 1014:1012 /usr/share/docker/rabbitmq/
	chown -R 1014:1012 /u01/docker/docker_log/rabbitmq/
```
 * For First Node in Cluster run:
 ```bash
	docker run  -d  --network=host --name rabbitmq-server --privileged  -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq   -v /usr/share/docker/:/usr/share/docker/  -v /var/lib/rabbitmq:/var/lib/rabbitmq:shared   -u root -e RABBITMQ_START='BOOTSTRAP'   -e OPENSTACK_PASSWORD="opspassword"   tovanlam/rabbitmq:latest
```
> ***You should change opspassword to the password you want to use in openstack infrastructure***

 * For another Node in Cluster run:
 ```bash
	docker run  -d  --network=host  --name rabbitmq-server --privileged  -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq    -v /usr/share/docker/:/usr/share/docker/  -v /var/lib/rabbitmq:/var/lib/rabbitmq:shared  -u root -e RABBITMQ_START='INIT_RABBITMQ_CLUSTER'   -e RABBITMQ_HUB="RABBITMQHUB"  tovanlam/rabbitmq:latest
```
> 	***with RABBITMQHUB is hostname or ip of first Node.***

## Tutorials & Documentation

 * To view cluster info run:
  ```bash
 	docker exec -it rabbitmq-server rabbitmqctl cluster_status
 	docker exec -it rabbitmq-server rabbitmqctl status
 ```
 * When done setup cluster exit each Node out and rejoin cluster by command:
 ```bash
 	docker stop rabbitmq-server
 	docker rm rabbitmq-server
 	docker run  -d  --name rabbitmq-server --network=host --privileged -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq  -v /var/lib/rabbitmq/:/var/lib/rabbitmq/:shared  -v /usr/share/docker/:/usr/share/docker/    -u root -e RABBITMQ_START='START_RABBITMQ'   -e RABBITMQ_HUB="compute03"  tovanlam/rabbitmq:latest
 ```
 * [CLI tools guide](https://rabbitmq.com/cli.html) 
 * [Configuration guide](https://rabbitmq.com/configure.html) 
 * [Client libraries and tools](https://rabbitmq.com/devtools.html)



## Getting Help
 * See how it work in start.sh
 *  my email: tovanlam20132223@gmail.com
 * [Commercial support](https://rabbitmq.com/services.html) from [Pivotal](https://pivotal.io) for open source RabbitMQ
 * [Community Slack](https://rabbitmq-slack.herokuapp.com/)



## Contributing

Questions about contributing, internals and so on are very welcome on the mail *tovanlam20132223@gmail.com*




