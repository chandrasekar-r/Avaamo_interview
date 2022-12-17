# Avaamo_interview

## Git commands:

1. How do you set up a script to run every time a repository receives new commits through push?

        To configure  a script to run everytime a repository receives new commit, we can use pre-receive/update/post-receive hook available in repository's .git/hook folder.
        Post-receive hook is invoked after the updates have been updated into the destination repo. Post-receive hook is an ideal place to configure the simple deployment scripts. The hooks can be a simple python/bash/shell script in executable format.

    sample python script to send email
    ```
    #!/usr/bin/env python

    import smtplib
    from email.mime.text import MIMEText
    from subprocess import check_output

    # Get the git log --stat entry of the new commit
    log = check_output(['git', 'log', '-1', '--stat', 'HEAD'])

    # Create a plaintext email message
    msg = MIMEText("Look, I'm actually doing some work:\n\n%s" % log)

    msg['Subject'] = 'Git post-commit hook notification'
    msg['From'] = 'test1@example.com'
    msg['To'] = 'test2@example.com'

    # Send the message
    SMTP_SERVER = 'smtp.example.com'
    SMTP_PORT = 587

    session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
    session.ehlo()
    session.starttls()
    session.ehlo()
    session.login(msg['From'], 'secretPassword')

    session.sendmail(msg['From'], msg['To'], msg.as_string())
    session.quit()
    ```

2. How do you find a list of files that have changed in a particular commit?

    ```
    git log --raw (shows list of changed files in each commit)
    git diff-tree -r <commit_id> (shlows list of changed files for a particular commit)
    git whatchanged (shows list of changed files in each commit) ```


## Monitoring using scripts

1. Monitor a log file, detect a pattern detection, send an email on detection

    ```
    tail -f logfile | \
    while read line; do
        echo "$line" | grep "Pattern to search"
        if [  $? = 0]
        then
            mail -s "$SUBJECT" "$TO" < $MESSGAE
            fi
    done
    ```

2. Monitor process particular process on an instance, send an email on incase of state change like process got stopped, taking more CPU that threshold.

        Below script monitors a process names DURecorder. If the process doesn't exist, the script with send out an email. We can run this script as a cron job periodically to monitor the process.

    ```
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
    ```

## Docker:

1. Create a sample docker container with a Node.js Express app and demonstrate the installation.

        Guidelines :
        ● You should be able to find what system packages are needed by looking through the app
        ● You should not need to change the app code in any way
        ● The app should be running as a non-privileged user
        ● The app should be automatically restarted if crashes or is killed
        ● The app should maximize all of the available CPUs
        ● Timezone should be in IST
        ● Follow best practices when writing a dockerfile


    ```
    Refer Nodejs folder.
    ```

## Security:
1. Show how to block ports
    ```iptables -A input -p tcp --destination-port [portnumber] -j DROP ```

2. Show how to setup port forwarding
    Local port 443 is routed to 8443
     ```   iptables -A PREROUTING -t nat -i ens4 -p tcp --dport 443 -j REDIRECT --to-port 8443```


## Network:
1. Show list of processes using the network.
    ``` lsof -i 4 // shows process based on their Internet address ipv4 ```
2. Show the list of IPs a process is connected to
    Below command shows list of IPs running on port 80.
    ```  netstat -tn 2>/dev/null | grep :80 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head ```
3. Show how to list open files and kill processes tied to a user
    ` kill -9 $(lsof -t -u $USER) `


## Code:
Write a short program that prints each number from 1 to 100 on a new line.
For each multiple of 3, print "AVA" instead of the number.
For each multiple of 5, print "AMO" instead of the number.
For numbers which are multiples of both 3 and 5, print "AVAAMO" instead of the number.

```
#/bin/env python
x = 0
y = 0
z = ""
for i in range(1,101):
    x = x+1
    y = y+1
    if(x == 3):
        z = z + "ava"
        x = 0
    if(y == 5):
        z = z + "amo"
        y = 0
    if(z == ""):
        print(i)
    else:
        print(z)
    z = ""
```
