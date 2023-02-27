#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root so i can access nginx logs"
  exit
fi


CLEAR='\033[0m'
RED='\033[0;31m'          
GREEN='\033[0;32m'        


HOSTS=$(grep -h -E "server_name\s+" /etc/nginx/conf.d/* | awk '{print $2}' | sort -u | cut -f1 -d';')

for HOST in $HOSTS;do
  echo -e "Checking logs for ${GREEN}$HOST${CLEAR}"
  
  LOG_FILE="/var/log/nginx/"$HOST"_error.log"
    if [ ! -f $LOG_FILE ]; then
    echo -e "No log file found for ${GREEN}$HOST${CLEAR}"
    echo $HOST >> /tmp/no-log-hosts
        read -p "Press any key to continue to the next host..."
    clear
    continue
  fi
  
  access_forbidden_logs=$(grep " forbidden " $LOG_FILE | awk '{print $1 " - " $7}' | sort | uniq -c | sort -nr) 
    if [ -z "$access_forbidden_logs" ]; then
    echo -e "No access forbidden logs found for ${GREEN}$HOST${CLEAR}"
    echo $HOST >> /tmp/no-forbidden-log-hosts
        read -p "Press any key to continue to the next host..."
    clear
    continue
  fi

  awk '/ forbidden / {print $11 " " $16;}' "$LOG_FILE" | sort | uniq -c | sort -nr | while read COUNT URI; do
  url=$(echo -e $URI | cut -f2 -d ,)
  ip=$(echo -e $URI | cut -f1 -d ,)
  echo -e "${RED}$COUNT${CLEAR} requests from ${RED}$ip${CLEAR} on${GREEN}$url${CLEAR}"
  done
    read -p "Press any key to continue to the next host..."
    clear
done
echo "hosts with no logs or no forbidden logs were saved to /tmp/no-log-hosts and /tmp/no-forbidden-log-hosts"
echo "you can remove them from hosts list in this script if you want"

