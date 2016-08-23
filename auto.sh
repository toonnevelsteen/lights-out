#!/usr/bin/env bash
#Crontab entry, trying to schedule it during the night, rterying several times
#0 2,3,4,5 * * * /home/pi/bin/auto.sh

curl http://lichten.ne-ge.be/auto
