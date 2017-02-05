#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_conf=/etc/named.conf

yum -y install bind bind-chroot

\cp -p $var_conf $var_conf${var_prefix_org:?}
curl iac.yakosei.com/etc/named.conf >$var_conf
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf


