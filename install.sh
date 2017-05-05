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

if ! grep -q "\.DS_Store" ~/.gitignore; then
    echo .DS_Store >> ~/.gitignore
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
##  Create SSH key & upload to Github                                         ##
################################################################################
echo "Task: create ssh key"
if [ ! -f ~/.ssh/id_rsa ]; then
    echo " >> create new ssh key and add to github.com"
    ssh-keygen -f id_rsa -t rsa -N '' -C 'ekcode@icloud.com' -f ~/.ssh/id_rsa
    curl -u "ekcode" --data "{\"title\":\"\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
else
    echo " >> ssh key already exists"
fi



################################################################################
##  Clone git repository                                                      ##
################################################################################
echo "Task: clone all my github repositories"
USER=ekcode; cd ~/github && curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
cd - > /dev/null


################################################################################
##  VIM                                                                       ##
################################################################################
if [ ! -d ~/.vim_runtime ]; then
    echo "Task: setup vim"
    git clone https://github.com/ekcode/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


################################################################################
##  ZSH                                                                       ##
################################################################################
echo "Task: install zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/oh-my-zsh/master/tools/install.sh)"


################################################################################
##  ZSH plugins                                                               ##
################################################################################
if ! grep -q "plugins=\(git\)" ~/.zshrc; then
    echo "Task: set zsh plugins"
    sed -i '' -e 's/plugins=(git)/plugins=(git autojump colored-man zsh-syntax-highlighting dakao)/' ~/.zshrc
fi


################################################################################
##  ZSH theme                                                                 ##
################################################################################
if grep -q "ZSH_THEME=\"robbyrussell\"" ~/.zshrc; then
    echo "Task: set zsh theme"
    sed -i '' -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
fi


################################################################################
##  System environments                                                       ##
################################################################################
if ! grep -q "export LC_ALL=\"ko_KR.UTF-8\"" ~/.zshrc; then
    echo "Task: export LC_ALL"
    printf "export LC_ALL=\"ko_KR.UTF-8\"" >> ~/.zshrc
fi


################################################################################
##  scm breeze                                                                ##
################################################################################
if [ ! -d ~/.scm_breeze ]; then
    echo "Task: install scm_breeze"
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi


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


################################################################################
##  Java                                                                      ##
################################################################################
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


################################################################################
##  Powerline fonts                                                           ##
################################################################################
echo "Task: install powerline fonts"
if [ -n "`\ls ~/Library/Fonts/*Powerline*`" ]; then
    echo ' >> powerline fonts already installed'
else
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi
echo ' >> iTerm2 > Preferences > Profiles > Color > Solarized Dark'
echo ' >> iTerm2 > Preferences > Profiles > Text > 12pt Meslo LG M Regular for Powerline'
