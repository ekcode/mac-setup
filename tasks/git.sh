#!/bin/bash

################################################################################
##  Create SSH key & upload to Github                                         ##
################################################################################
echo "Task: create ssh key"
if [ ! -f ~/.ssh/id_rsa ]; then
    echo " >> create new ssh key and add to github.com"
    ssh-keygen -f id_rsa -t rsa -N '' -C 'ekcode@icloud.com' -f ~/.ssh/id_rsa
else
    echo " >> ssh key already exists"
fi
echo " >> regist public key to github"
curl -u "ekcode" --data "{\"title\":\"\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys


################################################################################
##  Git configuration                                                         ##
################################################################################
echo "Task: git config globally"
git config --global user.name "Ickhyun Kwon"
git config --global user.email "ekcode@icloud.com"
git config --global branch.master.remote origin
git config --global branch.master.merge refs/heads/master
git config --global push.default simple
git config --global remote.origin.push HEAD
git config --global core.excludesfile ~/.gitignore
git config --global core.editor /usr/bin/vim

if ! grep -q "\.DS_Store" ~/.gitignore; then
    echo .DS_Store >> ~/.gitignore
fi


################################################################################
##  Clone git repository                                                      ##
################################################################################
echo "Task: clone all my github repositories"
USER=ekcode; cd ~/github && curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
cd - > /dev/null
