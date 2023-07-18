#!/bin/bash

# Variables
server=$1
username=$2
password=$3
database=$4
backup_path=$5

# Cd to path
cd $backup_path

# Create folder with month name if does not exist
current_month=$(date +%B)
mkdir -p $current_month

# Ensure permission to backup folder
chown -R mssql $backup_path

# Get current date time
current_datetime=$(date +"%Y-%m-%d(%H:%M:%S)")

# Connect to SQL Server and perform backup
sqlcmd -S $server -U $username -P $password -Q "BACKUP DATABASE $database TO DISK='$backup_path/$current_month/backup-$current_datetime.bak'"

# Remove all dirs EXCEPT from current month
directories=$(ls -d */)
for dir in $directories; do
  dir_name=$(basename "$dir")
  if [[ $dir_name != $current_month ]]; then
	rm -r $dir_name
  fi
done
