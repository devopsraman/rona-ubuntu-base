#!/bin/bash
echo "Loading aliases"

COLORS=""
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    COLORS=" --color=auto "
fi

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll="ls -l -h ${COLORS}"
alias grep="grep -i ${COLORS}"
alias ln="ln -s"

alias df="df -h"
alias du="du -shc "
alias ds="df -sh"

APTG="apt-get"
APTC="apt-cache"
alias ins="dpkg --list | grep "
alias agu="sudo ${APTG} update"
alias agd="sudo ${APTG} dist-upgrade"
alias agi="sudo ${APTG} install"
alias ari="sudo ${APTG} install --reinstall"
alias agr="sudo ${APTG} remove"
alias agp="sudo ${APTG} purge"
alias acs="${APTC} search"
alias acsh="${APTC} show"

alias psi='ps h -eo pmem,comm | sort -nr | head'
alias pg='ps -efww | grep -v grep | grep -i '
alias pj='ps -efww | grep -v grep | grep java'
