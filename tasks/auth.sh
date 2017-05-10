#!/bin/bash

################################################################################
##  Daum Auth                                                                 ##
################################################################################
AUTH_DIR="/usr/local/daum/"
AUTH_FILE="ADKEY.dat"
echo "Task: install daum auth file"
if [ ! -f $AUTH_DIR$AUTH_FILE ]; then
    git clone https://ricardo.kwon@github.daumkakao.com/ricardo-kwon/dev-setup.git
    sudo mkdir -p $AUTH_DIR
    sudo cp dev-setup/tasks/files/$AUTH_FILE $AUTH_DIR
    rm -rf dev-setup
    echo " >> installed"
else
    echo " >> already installed"
fi

