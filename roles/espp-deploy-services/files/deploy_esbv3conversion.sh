#!/bin/sh

STACK_NAME=ekassir_rshb
SERVICE_NAME=esbv3conversion

COMPOSE_FILE=deploy_${SERVICE_NAME}.yml

docker service rm ${STACK_NAME}_${SERVICE_NAME}
for item in $(docker secret ls --quiet --filter "NAME=${STACK_NAME}_${SERVICE_NAME}-"); do docker secret rm $item; done
docker stack deploy --with-registry-auth -c $COMPOSE_FILE $STACK_NAME
