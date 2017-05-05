#!/bin/bash

################################################################################
##  Java                                                                      ##
################################################################################
SECURITY_DIR="`/usr/libexec/java_home`/jre/lib/security"
echo "Task: install jre/lib/security files"
if [ ! -f $SECURITY_DIR/US_export_policy.jar.bak ]; then
    sudo cp $SECURITY_DIR/US_export_policy.jar $SECURITY_DIR/US_export_policy.jar.bak
    sudo cp $SECURITY_DIR/local_policy.jar $SECURITY_DIR/local_policy.jar.bak
    sudo curl -L https://raw.githubusercontent.com/ekcode/mac-setup/kakao/java-security-lib/local_policy.jar -o $SECURITY_DIR/local_policy.jar
    sudo curl -L https://raw.githubusercontent.com/ekcode/mac-setup/kakao/java-security-lib/US_export_policy.jar -o $SECURITY_DIR/US_export_policy.jar
    echo " >> installed"
else
    echo " >> already installed"
fi

