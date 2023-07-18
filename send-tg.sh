#!/bin/bash

# TG config
TOKEN=$1
CHAT_ID=$2
MESSAGE=$3

# Send a message using the Telegram Bot API
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MESSAGE" >/dev/null
