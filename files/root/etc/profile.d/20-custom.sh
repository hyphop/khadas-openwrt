#!/bin/sh

alias showfd='ls -l1 /proc/$$/fd'
alias rebootnow='echo 1 > /proc/sys/kernel/sysrq; echo b > /proc/sysrq-trigger'
