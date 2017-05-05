#!/bin/bash

################################################################################
##  System environments                                                       ##
################################################################################
if ! grep -q "export LC_ALL=\"ko_KR.UTF-8\"" ~/.zshrc; then
    echo "Task: export LC_ALL"
    echo "export LC_ALL=\"ko_KR.UTF-8\"" >> ~/.zshrc
fi
