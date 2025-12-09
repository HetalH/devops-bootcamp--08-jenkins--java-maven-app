#!/usr/bin/env bash

export TAGS=$1
docker-compose -f docker-compose.yaml up --detach
echo "success"