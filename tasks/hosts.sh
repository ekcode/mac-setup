#!/bin/bash

################################################################################
##  /etc/hosts                                                                ##
################################################################################
echo "Task: configure /etc/hosts"
if ! grep -q "local.publisher.daumtools.com" /etc/hosts; then
    sudo sh -c 'printf "\n127.0.0.1    local.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1    local.frontview.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1    local.publisher.biz.daum.net" >> /etc/hosts'
    echo " >> /etc/hosts modified"
else
    echo " >> already modified"
fi
