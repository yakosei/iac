#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')

yum -y install bind bind-chroot

var_conf=/etc/named.conf
\cp -p $var_conf $var_conf${var_prefix_org:?}
curl iac.yakosei.com/etc/named.conf >$var_conf
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf

var_zone=/var/named/chroot/var/named/0x0130.com.zone
\cp -p $var_zone $var_zone${var_prefix_org:?}
curl iac.yakosei.com/var/named/0x0130.com.zone >$var_zone
[ "$(diff $var_zone $var_zone$var_prefix_org)" ] || \mv -f $var_zone$var_prefix_org $var_zone

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --list-services --zone=public  --permanent
firewall-cmd --add-service=dns --zone=public --permanent
firewall-cmd --list-services --zone=public  --permanent
firewall-cmd --reload

systemctl start named-chroot
systemctl enable named-chroot

