#!/bin/bash

export TODAY=$(date +"%d%b%Y")
export DB_BACKUP_PATH=""

export MODE=
export CUSTOMER=
export DISCORD_WEBHOOK_URL=
export AWS_DIR=s3://bucketname/${MODE}/${COMPANY_NAME}/
export DATABASES=()
export SERVER_IP=

export MYSQL_HOST=
export MYSQL_PORT=
export MYSQL_USER=
export MYSQL_PASSWORD=
export CONTAINER=
export BACKUP_RETAIN_DAYS=30   
export PATH=/bin:/usr/bin:/usr/local/bin

export DB_USER=
export DB_PASSWORD=
export DB_HOST=
export DB_NAMES=()
export DB_COUNT=${#DB_NAMES[@]}
export DB_PORT=3306

export IMAGES=()
export CONTAINERS=()
export CONTAINER_COUNT=${#CONTAINERS[@]}
