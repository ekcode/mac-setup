#!/bin/bash

## Homebrew
echo "Task: homebrew"
if ! command -v brew > /dev/null; then
    echo " >> run xcode-select"
    xcode-select --install
    echo " >> install homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo " >> already installed"
    brew update
    brew upgrade
fi

brew doctor

echo "Task: install apps by brew cask"
brew cask install java \
    google-chrome \
    intellij-idea \
    sourcetree \
    iterm2 \
    enpass \
    atom \
    dropbox \
    google-photos-backup \
    google-trends


echo "Task: install packages by brew"
brew install git \
    git-flow \
    ansible \
    grip \
    fzf \
    autojump \
    httpstat \
    leiningen \
    less \
    maven \
    node \
    openssl \
    pyenv \
    pyenv-virtualenv \
    autoenv \
    python \
    python3 \
    ripgrep \
    sbt \
    tig \
    tree \
    mongodb \
    yarn \
    heroku

## fzf
echo "Task: configure fzf"
/usr/local/opt/fzf/install --all
if ! grep -q "set rtp+=\/usr\/local\/opt\/fzf" ~/.vimrc; then
    printf "\nset rtp+=/usr/local/opt/fzf" >> ~/.vimrc
else
    echo " - fzf is already configured"
fi

## git config
echo "Task: git config globally"
git config --global user.name "Ickhyun Kwon"
git config --global user.email "ekcode@icloud.com"
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore
echo .DS_Store >> ~/.gitignore

if [ ! -d ~/github ]; then
    echo "Task: create  ~/github directory"
    mkdir ~/github
fi

if [ ! -d ~/works ]; then
    echo "Task: create  ~/works directory"
    mkdir ~/works
fi

## create id_rsa key
echo "Task: create ssh key"
if [ ! -f ~/.ssh/id_rsa ]; then
    echo " >> create new ssh key and add to github.com"
    ssh-keygen -f id_rsa -t rsa -N '' -C 'ekcode@icloud.com' -f ~/.ssh/id_rsa
    curl -u "ekcode" --data "{\"title\":\"\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
else
    echo " >> ssh key already exists"
fi



## clone all my github repos
echo "Task: clone all my github repositories"
USER=ekcode; cd ~/github && curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
cd - > /dev/null


## vim setup
if [ ! -d ~/.vim_runtime ]; then
    echo "Task: setup vim"
    git clone https://github.com/ekcode/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


## install oh-my-zsh
echo "Task: install zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/oh-my-zsh/master/tools/install.sh)"


## scm_breeze
if [ ! -d ~/.scm_breeze ]; then
    echo "Task: install scm_breeze"
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi

if ! grep -q "plugins=\(git\)" ~/.zshrc; then
    echo "Task: settings for zsh plugins"
    sed -i '' -e 's/plugins=(git)/plugins=(git autojump)/' ~/.zshrc
fi

## hosts
echo "Task: configure /etc/hosts"
if ! grep -q "local.publisher.daumtools.com" /etc/hosts; then
    sudo sh -c 'printf "\n127.0.0.1    local.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1    local.frontview.publisher.daumtools.com" >> /etc/hosts'
    sudo sh -c 'printf "\n127.0.0.1    local.publisher.biz.daum.net" >> /etc/hosts'
    echo " >> /etc/hosts modified"
else
    echo " >> already modified"
fi


## java lib/security
SECURITY_DIR="`/usr/libexec/java_home`/jre/lib/security"
echo "Task: install jre/lib/security files"
if [ ! -f $SECURITY_DIR/US_export_policy.jar.bak ]; then
    sudo cp $SECURITY_DIR/US_export_policy.jar $SECURITY_DIR/US_export_policy.jar.bak
    sudo cp $SECURITY_DIR/local_policy.jar $SECURITY_DIR/local_policy.jar.bak
    sudo curl -L https://raw.githubusercontent.com/ekcode/mac-setup/master/java-security-lib/local_policy.jar -o $SECURITY_DIR/local_policy.jar
    sudo curl -L https://raw.githubusercontent.com/ekcode/mac-setup/master/java-security-lib/US_export_policy.jar -o $SECURITY_DIR/US_export_policy.jar
    echo " >> installed"
else
    echo " >> already installed"
fi
