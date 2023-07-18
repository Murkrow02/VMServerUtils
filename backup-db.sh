#!/bin/bash

# Variables
server=$1
username=$2
password=$3
database=$4
backup_path=$5

# Cd to path
cd $backup_path

# Ensure permission to backup folder
chown  mssql $backup_path

# Get current date time
current_datetime=$(date +"%Y-%m-%d(%H:%M:%S)")

# Connect to SQL Server and perform backup
sqlcmd -S $server -U $username -P $password -Q "BACKUP DATABASE $database TO DISK='$backup_path/backup-$current_datetime.bak'"

# Maximum number of files to keep
max_files=5

# Change to the backup directory
cd "$backup_path" || exit

# List files in the directory by modification time, oldest first
files=($(ls -t))

# Delete excess files if the count exceeds the maximum
if [ ${#files[@]} -gt $max_files ]; then
  files_to_delete=$(( ${#files[@]} - max_files ))
  for ((i=0; i<$files_to_delete; i++)); do
    rm "${files[${#files[@]}-i-1]}"
    echo "Deleted file: ${files[${#files[@]}-i-1]}"
  done
fi
