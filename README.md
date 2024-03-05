# DBBackupAutomation

This repository contains a collection of scripts and configurations designed to automate the process of backing up databases to AWS S3 and notifying a Discord channel upon success or failure. This setup is intended to serve as a general-purpose solution for managing database backups across multiple environments.

## Overview

The system comprises three main components:

- `backupAllDatabase.sh`: The main script that iterates over a list of databases, triggers backups, uploads them to AWS S3, and sends notifications to Discord.
- `mysqlBackup.sh`: A helper script that performs the actual database backup using `mysqldump` and manages backup retention by deleting old backups.
- `config.sh`: A configuration file that defines various parameters such as backup paths, database credentials, AWS S3 directory, Discord webhook URL, and more.
- `Makefile`: Provides commands to install the backup script as a cron job, list current cron jobs, and remove the cron job.

## Installation and Use

1. Clone this repository to your server where the databases are hosted.
2. Customize the `config.sh` file with your own settings (AWS S3 bucket, Discord webhook, database credentials, etc.)
3. Fill in the SCRIPT_PATH and LOG_PATH fields in the makefile.
3. Run `make install` to set up the cron job for automatic backups.
4. Monitor your Discord channel for backup notifications.

## Features

- Automated backups for multiple databases
- Easy configuration of database details, backup retention period, and notification settings
- Backup uploads to AWS S3 for secure and scalable storage
- Discord notifications for backup completion status
- Cron job integration for scheduling backups

