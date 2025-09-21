#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOGFILE="system_health.log"

# CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_INT=${CPU_USAGE%.*}

# Memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_INT=${MEM_USAGE%.*}

# Disk usage
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

echo "----- $(date) -----" >> $LOGFILE

if [ $CPU_INT -gt $CPU_THRESHOLD ]; then
  echo "ALERT: High CPU usage - $CPU_INT%" | tee -a $LOGFILE
fi

if [ $MEM_INT -gt $MEM_THRESHOLD ]; then
  echo "ALERT: High Memory usage - $MEM_INT%" | tee -a $LOGFILE
fi

if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
  echo "ALERT: High Disk usage - $DISK_USAGE%" | tee -a $LOGFILE
fi

# Running processes
echo "Top 5 processes by memory:" >> $LOGFILE
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6 >> $LOGFILE
