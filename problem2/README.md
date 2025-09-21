## Problem Statement 2
I have implemented two objectives in Bash:

1. **System Health Monitoring Script**  
   File: `problem2/system_health.sh`  
   - Monitors CPU, Memory, Disk usage, and top processes.  
   - Logs alerts if thresholds are exceeded.  

2. **Application Health Checker**  
   File: `problem2/app_health.sh`  
   - Checks if an application is UP or DOWN using HTTP status code.  

### How to Run
```bash
# Run System Health Monitoring
./problem2/system_health.sh

# Run Application Health Checker
./problem2/app_health.sh