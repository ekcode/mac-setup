#!/bin/bash

################################################################################
##  ZSH                                                                       ##
################################################################################
echo "Task: install zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/oh-my-zsh/master/tools/install.sh)"

################################################################################
##  ZSH plugins                                                               ##
################################################################################
brew install zsh-syntax-highlighting
echo "Task: set zsh plugins"
sed -i '' -e 's/^plugins=(.*)/plugins=(git autojump colored-man-pages zsh-syntax-highlighting dakao)/' ~/.zshrc
if ! grep -q "source \/usr\/local\/share\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh" ~/.zshrc; then
    printf "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi


################################################################################
##  ZSH theme                                                                 ##
################################################################################
if grep -q "ZSH_THEME=\"robbyrussell\"" ~/.zshrc; then
    echo "Task: set zsh theme"
    sed -i '' -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
    echo "DEFAULT_USER=kakao" >> ~/.zshrc
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
