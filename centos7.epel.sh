#!/bin/bash
var_epel_dir='http://dl.fedoraproject.org/pub/epel/7/x86_64/e/'
var_epel_url=$var_epel_dir$(curl -kLRs $var_epel_dir | sed -r -e '/epel-release/!d' -e 's/^.*href="(epel-release.*\.rpm)".*$/\1/g')
yum -y install yum-utils $var_epel_url
yum-config-manager --disable epel*
