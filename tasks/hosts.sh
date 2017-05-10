#!/bin/bash

################################################################################
##  /etc/hosts                                                                ##
################################################################################
echo "Task: configure /etc/hosts"
if ! grep -q "local.publisher.daumtools.com" /etc/hosts; then
    sudo sh -c 'printf "\n127.0.0.1\tlocal.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1\tlocal.frontview.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1\tlocal.publisher.biz.daum.net" >> /etc/hosts'
fi

if ! grep -q "127.0.0.1\t`hostname`" /etc/hosts; then
    sudo sh -c 'printf "\n\n127.0.0.1\t`hostname`" >> /etc/hosts'
fi

if ! grep -q "::1\t`hostname`" /etc/hosts; then
    sudo sh -c 'printf "\n::1\t`hostname`" >> /etc/hosts'
fi
