#!/bin/bash

cd "$(dirname "$0")"
set -o pipefail
source config.sh

echo "$(date +"%Y-%m-%d %T") $0: MySQL Dump Event is starting."
for i in "${DATABASES[@]}"; do
    echo "$(date +"%Y-%m-%d %T") mysqlBackup.sh: Backing up $i Database"
    if ! ./mysqlBackup.sh "$i"; then
        MYSQLBACKUP_MESSAGE_CONTENT=":rotating_light: **Backup All Database Failed** :rotating_light:\n\n**Customer:** $CUSTOMER\n**Server IP Address:** $SERVER_IP\n\n:bangbang: **Status:** mysqlBackup.sh ERROR\n\n:page_facing_up: **Description:** backupalldatabase.sh failed for $i database during mysqlBackup "
        curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"${MYSQLBACKUP_MESSAGE_CONTENT}\"}" $DISCORD_WEBHOOK_URL
        echo $ERROR_OUTPUT_MYSQL_BACKUP
        exit 1
    else
        echo "$(date +"%Y-%m-%d %T") mysqlBackup.sh: database $i backup has been completed"
        echo "$(date +"%Y-%m-%d %T") $0: Uploading $i backup to S3..."
        aws s3 cp "${DB_BACKUP_PATH}/${TODAY}/$i-${TODAY}.sql.gz" "${AWS_DIR}/$i-${TODAY}.sql.gz"
        if [ $? -ne 0 ]; then
            S3_MESSAGE_CONTENT=":rotating_light: **Backup All Database Failed** :rotating_light:\n\n**Customer:** $CUSTOMER\n**Server IP Address:** $SERVER_IP\n\n:bangbang: **Status:** S3 Push ERROR\n\n:page_facing_up: **Description:** backupalldatabase.sh failed during AWS S3 upload for database $i "
            curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"${S3_MESSAGE_CONTENT}\"}" $DISCORD_WEBHOOK_URL
            exit 1
        fi
        echo "$(date +"%Y-%m-%d %T") $0:Database $i backup uploaded successfully to S3."
    fi
done

echo "$(date +"%Y-%m-%d %T") $0: DB Backup Event is completed."



