#!/bin/bash
device=lo

echo "Network emulation: DELAY"
echo "We need sudo privileges here change device '${device}'"
read -s -p "Enter Password for sudo: " sudoPW
echo $sudoPW | sudo -S tc qdisc add dev ${device} root handle 1: prio
echo $sudoPW | sudo -S tc qdisc add dev ${device} parent 1:3 handle 30: netem delay 250ms
echo $sudoPW | sudo -S tc filter add dev ${device} protocol ip parent 1:0 u32 match ip dport 35100 0xffff flowid 1:3
