## Homebrew
if ! command -v brew > /dev/null; then
    xcode-select --install
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
    brew upgrade
fi
brew doctor


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


brew install git \
	git-flow \
	ansible \
	grip \
    fzf \
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

git config --global user.name "Ickhyun Kwon"
git config --global user.email "ekcode@icloud.com"


if [ ! -d ~/github ]; then
    mkdir ~/github
fi

if [ ! -d ~/works ]; then
    mkdir ~/works
fi


## vim setup
if [ ! -d ~/.vim_runtime ]; then
    git clone https://github.com/ekcode/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


## scm_breeze
if [ ! -d ~/.scm_breeze ]; then
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi


## zsh

if ! command -v zsh > /dev/null; then
    bash --rcfile zsh_install.sh
fi
