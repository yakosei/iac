#!/bin/bash
prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
selinux_conf=/etc/selinux/config
setenforce 0
\cp -p $selinux_conf $selinux_conf${prefix_org:?}
sed -r 's/^[ \t]*(SELINUX=[ep].+)/#\1\n# '"$(date +'Edit %Y%m%d by iac')"'\nSELINUX=disabled/g' $selinux_conf -i
[ "$(diff $selinux_conf $selinux_conf$prefix_org)" ] || rm -f $selinux_conf$prefix_org
