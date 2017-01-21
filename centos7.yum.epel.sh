#!/bin/bash
epel_dir='http://dl.fedoraproject.org/pub/epel/7/x86_64/e/'
epel_url=$epel_dir$(curl -kLRs $epel_dir | sed -r -e '/epel-release/!d' -e 's/^.*href="(epel-release.*\.rpm)".*$/\1/g')
yum -y install yum-utils $epel_url
yum-config-manager --disable epel*
