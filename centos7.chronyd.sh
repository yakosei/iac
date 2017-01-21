#!/bin/bash
prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
yum -y install chrony
ntp_srv=ntp.nict.jp
ntp_conf=/etc/chrony.conf
\cp -p $ntp_conf $ntp_conf$prefix_org
sed -r 's/^(server 0.[cr][a-z]+.pool.ntp.org iburst).*/# '"$(date +'Edit %Y%m%d by iac')"'\n#\1\nserver '$ntp_srv' iburst/g' $ntp_conf -i
[ "$(diff $ntp_conf $ntp_conf$prefix_org)" ] || rm -f $ntp_conf${prefix_org:?}
systemctl start chronyd
systemctl enable chronyd
chronyc -a makestep
