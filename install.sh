#!/bin/bash

################################################################################
##  Homebrew                                                                  ##
################################################################################
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
    brew cleanup
fi

brew doctor

################################################################################
##  Install apps by brew cask                                                 ##
################################################################################
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
    google-trends \
    vagrant \
    vagrant-manager \
    docker \
    caffeine

################################################################################
##  Quick view plugins                                                        ##
################################################################################
brew cask install qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    qlimagesize \
    webpquicklook \
    suspicious-package \
    quicklookase \
    qlvideo

################################################################################
##  Install packages using brew                                               ##
################################################################################
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
    heroku \
    ack

################################################################################
##  fzf                                                                       ##
################################################################################
echo "Task: configure fzf"
/usr/local/opt/fzf/install --all
if ! grep -q "set rtp+=\/usr\/local\/opt\/fzf" ~/.vimrc; then
    printf "\nset rtp+=/usr/local/opt/fzf" >> ~/.vimrc
else
    echo " - fzf is already configured"
fi


################################################################################
##  Create working directory                                                  ##
################################################################################
if [ ! -d ~/github ]; then
    echo "Task: create  ~/github directory"
    mkdir ~/github
fi

if [ ! -d ~/works ]; then
    echo "Task: create  ~/works directory"
    mkdir ~/works
fi


################################################################################
##  VIM                                                                       ##
################################################################################
if [ ! -d ~/.vim_runtime ]; then
    echo "Task: setup vim"
    git clone https://github.com/ekcode/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


################################################################################
##  Execute sub tasks                                                         ##
################################################################################
if [ "$0" == "sh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/oh-my-zsh.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/system-env.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/java.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/hosts.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/git.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/mac-setup/kakao/tasks/scm-breeze.sh)"
else
    sh tasks/oh-my-zsh.sh
    sh tasks/system-env.sh
    sh tasks/java.sh
    sh tasks/hosts.sh
    sh tasks/git.sh
    sh tasks/scm-breeze.sh
fi
