#!/bin/bash

# Check if both script path and interval are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <script_path> <interval_in_days>"
  exit 1
fi

# Path to the shell script
sh_file="$1"

# Interval in days
interval_days="$2"

# Calculate the interval in minutes
interval_minutes=$((interval_days * 24 * 60))

# Create a temporary cron file
cron_file=$(mktemp)

# Copy existing cron schedule to temporary file
crontab -l > "$cron_file"

# Append the new cron schedule to the temporary file
echo "*/$interval_minutes * * * * $sh_file" >> "$cron_file"

# Install the updated cron job from the temporary file
crontab "$cron_file"

# Remove the temporary cron file
rm "$cron_file"

echo "Scheduled $sh_file to run every $interval_days day(s)."
