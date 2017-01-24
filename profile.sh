#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_profile_d=/etc/profile.d/z-user-data.sh
[ -f $var_profile_d ] || touch $var_profile_d
\cp -p $var_profile_d $var_profile_d${var_prefix_org:?}
cat <<'__EOD__' >$var_profile_d
# User specific aliases and functions
# Generate by iac

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# commands
cat <<_INIT_

        date | $(date)
    hostname | $(uname -n)
      whoami | $(whoami)

_INIT_

# aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias crontab='crontab -i'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -l'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias grep='grep --color=always'

# visudo
[ -f '/usr/bin/vi'  ] && alias visudo="EDITOR='/usr/bin/vi' visudo"
[ -f '/usr/bin/vim' ] && alias visudo="EDITOR='/usr/bin/vim' visudo"

# interactive shells
PS1='[\u@\h $(date +%H:%M:%S) \W]\$ '

# history timestamp ISO 8601
HISTTIMEFORMAT='%Y-%m-%dT%T%z '

# functions
HeadHighlight() { head $@ | sed -r -e 's/^(==>.+<==)$/'$'\e[31m''\1'$'\e[0m''/g'; }
alias head='HeadHighlight'

TailHighlight() { tail $@ | sed -r -e 's/^(==>.+<==)$/'$'\e[31m''\1'$'\e[0m''/g'; }
alias tail='TailHighlight'

VimBackup() { local _bak="$1-$(date +%Y%m%d-%H%M%S).bak"; [ -f "$1" ] && cp -pi "$1" "$_bak"; vim "$1"; if [ "$(diff "$1" "$_bak" 2>/dev/stdout)" ]; then ls --color=auto -dhl $1*; else [ -f "$_bak" ] && rm -f "$_bak"; fi; }
alias vim='VimBackup'
alias vi='VimBackup'

#EOF
__EOD__
[ "$(diff $var_profile_d $var_profile_d$var_prefix_org)" ] || \mv -f $var_profile_d$var_prefix_org $var_profile_d
