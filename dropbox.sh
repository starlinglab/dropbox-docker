#!/bin/sh

# Check if upgrade happend, if so re-arange files
if [ -d "/home/dropbox-user/.dropbox-dist" ]
then
    echo ERROR: Upgrade detecting, mitigating
    rm -rf /opt/dropbox/.dropbox-dist
    mv /home/dropbox-user/.dropbox-dist /opt/dropbox/.dropbox-dist
fi

rm -rf /home/dropbox-user/.dropbox/dropbox.pid
/opt/dropbox/.dropbox-dist/dropboxd
