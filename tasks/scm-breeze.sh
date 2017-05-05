#!/bin/bash

################################################################################
##  scm breeze                                                                ##
################################################################################
if [ ! -d ~/.scm_breeze ]; then
    echo "Task: install scm_breeze"
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi
