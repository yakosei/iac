#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_conf=/etc/sysconfig/i18n

\cp -p $var_conf $var_conf${var_prefix_org:?}
[ "$(grep 'LANG="en_US.UTF-8"' $var_conf)" ] || sed -r -e 's/^(LANG=.*)$/# '"$(date +'Edit %Y%m%d by iac')"'\n#\1\nLANG="en_US.UTF-8"/g' $var_conf -i
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf

. $var_conf

