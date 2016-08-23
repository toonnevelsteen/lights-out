#!/usr/bin/env bash
#Crontab entry, trying to schedule it during the night, rterying several times
#0 2,3,4,5 * * * /home/pi/bin/auto.sh

curl -u user:pwd http://lichten.ne-ge.be/auto
