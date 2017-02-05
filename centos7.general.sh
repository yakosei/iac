#!/bin/bash
curl iac.yakosei.com/centos7.selinux.sh | bash
curl iac.yakosei.com/authorized_keys.sh | bash
curl iac.yakosei.com/centos7.utils.sh | bash
curl iac.yakosei.com/centos7.timezone.sh | bash
curl iac.yakosei.com/centos7.locale.sh | bash
curl iac.yakosei.com/centos7.chrony.sh | bash
curl iac.yakosei.com/profile.sh | bash
curl iac.yakosei.com/vimrc.sh | bash
curl iac.yakosei.com/centos7.epel.sh | bash
yum --enablerepo=epel -y install bash-completion
curl iac.yakosei.com/centos7.jq.sh | bash
