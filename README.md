# Avaamo_interview

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
    
