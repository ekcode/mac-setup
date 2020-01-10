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
    datagrip \
    iterm2 \
    dropbox \
    google-backup-and-sync \
    vagrant \
    vagrant-manager \
    virtualbox \
    docker \
    cocoarestclient \
    firefox \
    visual-studio-code \
    dozer \
    fork
################################################################################
##  Quick view plugins                                                        ##
################################################################################
brew cask install qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
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
    ack

################################################################################
##  VIM                                                                       ##
################################################################################
if [ ! -d ~/.vim_runtime ]; then
    echo "Task: setup vim"
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


################################################################################
##  ZSH                                                                       ##
################################################################################
echo "Task: install zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh |  sed 's/env zsh//')"


################################################################################
##  scm breeze                                                                ##
################################################################################
if [ ! -d ~/.scm_breeze ]; then
    echo "Task: install scm_breeze"
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi

