#!/bin/bash

sudo -E copy_file.sh
if [ "$RABBITMQ_START" = "BOOTSTRAP" ]; then
        service rabbitmq-server start
        rabbitmqctl set_policy ha-all '.*' '{"ha-mode": "all"}'
        rabbitmqctl delete_user openstack
        rabbitmqctl add_user openstack "$OPENSTACK_PASSWORD"
        rabbitmqctl set_user_tags openstack administrator
        rabbitmqctl set_permissions openstack ".*" ".*" ".*"
        rabbitmq-plugins enable rabbitmq_management

        tail -f /var/log/rabbitmq/rabbit@*.log
elif [ "$RABBITMQ_START" = "INIT_RABBITMQ_CLUSTER" ]; then
        cat /var/lib/rabbitmq/.erlang.cookie
        service rabbitmq-server start
        rabbitmqctl stop_app
        # rabbitmqctl reset
        # rm /var/lib/rabbitmq/mnesia
        # rabbitmqctl join_cluster --ram rabbit@${HUB}
        rabbitmqctl join_cluster  rabbit@${RABBITMQ_HUB}
        rabbitmqctl start_app
        tail -f /var/log/rabbitmq/rabbit@*.log
elif [ "$RABBITMQ_START" = "START_RABBITMQ" ]; then
        service rabbitmq-server start
        tail -f /var/log/rabbitmq/rabbit@*.log
else
 echo "RABBITMQ_START is set to '$RABBITMQ_START'"
fi

