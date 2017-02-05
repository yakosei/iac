#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_conf=/etc/selinux/config

setenforce 0

\cp -p $var_conf $var_conf${var_prefix_org:?}
sed -r -e 's/^[ \t]*(SELINUX=[ep].+)/#\1\n# '"$(date +'Edit %Y%m%d by iac')"'\nSELINUX=disabled/g' $var_conf -i
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf

getenforce
