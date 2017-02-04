#!/bin/bash
curl iac.yakosei.com/centos7.utils.sh
curl iac.yakosei.com/centos7.selinux.sh
curl iac.yakosei.com/centos7.locale.sh
curl iac.yakosei.com/centos7.chrony.sh
mkdir -p -m 700 ~/.ssh; curl iac.yakosei.com/keys >>authorized_keys
curl iac.yakosei.com/profile.sh
curl iac.yakosei.com/vimrc.sh
