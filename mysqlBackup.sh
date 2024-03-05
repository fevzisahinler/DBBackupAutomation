#!/bin/bash

set -o pipefail
source config.sh

DATABASE_NAME="$1"

mkdir -p "${DB_BACKUP_PATH}/${TODAY}"
echo "$(date +"%Y-%m-%d %T") mysql_backup.sh: Backup started for ${DATABASE_NAME} database"

docker exec -i ${CONTAINER} mysqldump -h ${MYSQL_HOST} \
 -P ${MYSQL_PORT} "${DATABASE_NAME}" -u ${MYSQL_USER} -p${MYSQL_PASSWORD} | gzip > "${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz"

if [ $? -eq 0 ]; then
  echo "$(date +"%Y-%m-%d %T") Database backup successfully completed for ${DATABASE_NAME}"
else
  echo "$(date +"%Y-%m-%d %T") Error found during backup of ${DATABASE_NAME} & Deleted backup directory"
  rm -rf "${DB_BACKUP_PATH}/${TODAY}"
  exit 1
fi

echo "$(date +"%Y-%m-%d %T") mysql_backup.sh: ${DATABASE_NAME} database backup deletion ${BACKUP_RETAIN_DAYS} days ago started "
DBDELDATE=$(date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago")

cd ${DB_BACKUP_PATH}
if [ -d "${DBDELDATE}" ]; then
    rm -rf "${DBDELDATE}"
    echo "$(date +"%Y-%m-%d %T") mysql_backup.sh: Removed (${DBDELDATE}) backup folder & Script Successful"
else
    echo "$(date +"%Y-%m-%d %T") mysql_backup.sh: Database backup folder for database ${DATABASE_NAME} created 30 days ago to be deleted was not found. Continue"
fi

