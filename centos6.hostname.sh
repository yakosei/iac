#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')


hostname $HOSTNAME
sed -r 's/^(HOSTNAME=)(.*)$/# '"$edit_comment"'\n#\1\2\n\1'$HOSTNAME'/g' /etc/sysconfig/network -i
sed -r 's/(127\.0\.0\.1[ \t]+)(localhost[ \t]+.*)/# '"$edit_comment"'\n#\1\2\n\1'"$HOSTNAME ${HOSTNAME/.*}"' \2/g' /etc/hosts -i
cloud_cfg=/etc/cloud/cloud.cfg
cp -p $cloud_cfg $cloud_cfg$var_prefix_org
[ "$(grep 'preserve_hostname:.*true' $cloud_cfg)" ] || echo -e "\n\n# $edit_comment\npreserve_hostname: true" >>$cloud_cfg
[ "$(diff $cloud_cfg $cloud_cfg$var_prefix_org)" ] || rm -f $cloud_cfg$var_prefix_org
service network restart
