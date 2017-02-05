#!/bin/bash

iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
service iptables save

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.eth0.send_redirects=0

mkdir -p /etc/sysctl.d
cat <<__EOD__ >/etc/sysctl.d/nat.conf
# Edit $(date +%Y%m%d) by iac
net.ipv4.ip_forward = 1
net.ipv4.conf.eth0.send_redirects = 0
__EOD__
