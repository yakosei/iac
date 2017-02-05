#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')

yum -y install chrony

var_conf=/etc/chrony.conf
var_ntp_srv=ntp.nict.jp
\cp -p $var_conf $var_conf${var_prefix_org:?}
sed -r -e 's/^[ \t]*(server 0.[a-z]+.pool.ntp.org iburst.*)/# '"$(date +'Edit %Y%m%d by iac')"'\n#\1\nserver '$var_ntp_srv' iburst/g' $var_conf -i
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf

systemctl start chronyd
systemctl enable chronyd
systemctl status chronyd

chronyc -a makestep
