#!/bin/bash

hostname=$(hostname)
curr_Dt=$(date +"%Y-%m-%d %H:%M:%S")

#Get PID of a particuar process (DURecorder)
PID=$(ps -ef | grep -i '[/]DURecorder' | grep -v grep | awk '{print $2}')
cpu_usage=$(ps -p $PID -o %cpu | tail  -n 1)

if [[ -z ${PID} ]]; then
    # There is no PID, Not running!
    echo "ALERT TIME : $curr_Dt" >>monitor.txt
    echo "SERVER NAME : $hostname" >>monitor.txt
    echo "\n \n" >>monitor.txt
    echo " MSTRSvr is not running on $hostname Please check for possible impact " >>monitor.txt
    echo "\n \n" >>monitor.txt
    mail -s "DURecorder process ALERT" abc@aaa.com <monitor.txt

else
    echo " DURecorder with $PID is running with cpu thresold of $cpu_usage"
fi

