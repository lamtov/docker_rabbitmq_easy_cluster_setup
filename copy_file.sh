#!/bin/bash

#backup current config

cp -r /etc/${SERVICE} ${SHARED_CONF_DIR}/${SERVICE}/backup/${SERVICE}-$(date +%Y%m%d-%H%M%S)

#copy new configuration file
cp -r ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/. /etc/${SERVICE}/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts

cp -r ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/.erlang.cookie /var/lib/${SERVICE}/.erlang.cookie

#change permission
chown -R ${SERVICE}.${SERVICE} /etc/${SERVICE}/
chown -R ${SERVICE}.${SERVICE} /var/lib/${SERVICE}/
chown -R ${SERVICE}.${SERVICE} /var/log/${SERVICE}/
chmod 400 /var/lib/${SERVICE}/.erlang.cookie


cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
