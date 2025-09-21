#!/bin/bash

URL="https://example.com"
STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)

if [ "$STATUS" -eq 200 ]; then
  echo "Application is UP (HTTP $STATUS)"
else
  echo "Application is DOWN (HTTP $STATUS)"
fi
