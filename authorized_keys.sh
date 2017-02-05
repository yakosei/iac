#!/bin/bash
var_authorized_keys=~/.ssh/authorized_keys
if [ -z "$(grep -s yakosei $var_authorized_keys)" ]
then
    mkdir -p -m 700 ~/.ssh
    curl iac.yakosei.com/keys >>$var_authorized_keys
fi
