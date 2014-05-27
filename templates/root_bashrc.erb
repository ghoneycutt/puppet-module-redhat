# This file is being maintained by Puppet.
# DO NOT EDIT
#
# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias less='less -R'
alias duh='du -h'
alias dfh='df -h'

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# List of suffixes to ignore when performing filename completion
export FIGNORE=".svn:.o:~"

# vim is the default editor
export SVN_EDITOR='vim'
export EDITOR='vim'
export VISUAL='vim'

# Use less as our pager
export PAGER=/usr/bin/less
export LESS=-R

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

# display cert info
function certinfo () { openssl x509 -in $1 -noout -text; }

# display CSR info
function csrinfo () { openssl asn1parse -in $1; }

# puppet template syntax checking
function pt()
{
    if [ -z $1 ]; then
        echo "usage: pt <puppet_template_file.erb>"
        return;
    fi
    /usr/bin/erb -P -x -T '-' $1 | /usr/bin/ruby -c
}

# puppet manifest syntax checking
function pc()
{
    if [ -z $1 ]; then
        puppet parser validate init.pp
    else
        puppet parser validate $1
    fi
}
