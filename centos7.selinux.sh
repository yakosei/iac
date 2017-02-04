#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_selinux_conf=/etc/selinux/config
setenforce 0
\cp -p $var_selinux_conf $var_selinux_conf${var_prefix_org:?}
sed -r -e 's/^[ \t]*(SELINUX=[ep].+)/#\1\n# '"$(date +'Edit %Y%m%d by iac')"'\nSELINUX=disabled/g' $var_selinux_conf -i
[ "$(diff $var_selinux_conf $var_selinux_conf$var_prefix_org)" ] || \mv -f $var_selinux_conf$var_prefix_org $var_selinux_conf
getenforce
