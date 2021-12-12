#!/bin/bash
wall $'Architecture: '`uname -a` \
$'\n#CPU physical: '`cat /proc/cpuinfo | grep "physical id" | wc -l` \
$'\n #vCPU: '`cat proc/cpuinfo | grep processor | wc -l` \
$'\n#Memory Usage: '`free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)",$3,$2,$3*100/$2}'` \
$'\n#Disk Usage:'`df -h | awk '$NF=="/"{printf "%d/%dGB (%s)",$3,$2,$5}'` \
$'\n#CPU load:'`top -bn1 | grep load | awk '{printf "%.2f\n", $($NF-2)}'` \
$'\n#Last boot:'`who -b | awk 'print $3" "$4" "$5'` \
$'\n#LVM use: ' `lsblk | grep lvm | awk '{if ($1) {print "yes";exit;}else{print "no";}}'` \
$'\n#Connection TCP:' `netstat -an | grep ESTABLISHED | wc -l` ESTABLISHED\
$'\n#User log: ' `who | cut -d " " -f 1 | sort -u | wc -l` \
$'\n#Network: IP ' `hostname -I`"("`ip a | grep link/ether | awk '{print $2}'`")" \
$'\n#Sudo: ' `journalctl _COMM=sudo | grep COMMAND | wc -l` 'cmd'
