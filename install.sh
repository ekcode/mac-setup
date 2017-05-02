## Homebrew
if ! command -v brew > /dev/null; then
    echo "install homebrew"
    xcode-select --install
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "homebrew already installed"
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

echo "set git config globally"
git config --global user.name "Ickhyun Kwon"
git config --global user.email "ekcode@icloud.com"
git config --global core.excludesfile ~/.gitignore
echo .DS_Store >> ~/.gitignore


if [ ! -d ~/github ]; then
    mkdir ~/github
fi

if [ ! -d ~/works ]; then
    mkdir ~/works
fi

## create id_rsa key
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "create new ssh key and add to github.com"
    ssh-keygen -f id_rsa -t rsa -N '' -C 'ekcode@icloud.com'
    curl -u "ekcode" --data "{\"title\":\"\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
else
    echo "ssh key exists already"
fi



## clone all my github repos
echo "clone all my github repositories"
USER=ekcode; cd ~/github && curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone'"]'
cd -


## vim setup
if [ ! -d ~/.vim_runtime ]; then
    echo "setup vim"
    git clone https://github.com/ekcode/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi


## install oh-my-zsh
if ! command -v zsh > /dev/null; then
    echo "install zsh. input Ctrl+D after installing"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ekcode/oh-my-zsh/master/tools/install.sh)"
fi


## scm_breeze
if [ ! -d ~/.scm_breeze ]; then
    echo "install scm_breeze"
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
fi

if ! grep -q "plugins=(git)" ~/.zshrc; then
    echo "setup zsh plugins"
    sed -i 's/plugins=(git)/plugins=(git autojump)/' ~/.zshrc
fi

## hosts
host1="127.0.0.1	local.publisher.daumtools.com"
host2="127.0.0.1	local.frontview.publisher.daumtools.com"
host3="127.0.0.1	local.publisher.biz.daum.net"
echo "modify hosts"
if ! grep -q "$host1" /etc/hosts; then
    printf "\n$host1" >> /etc/hosts
    printf "\n$host2" >> /etc/hosts
    printf "\n$host3" >> /etc/hosts
    echo " - /etc/hosts modified"
else
    echo " - already modified. skipped"
fi


## java lib/securigy
SECURITY_DIR="`/usr/libexec/java_home`/jre/lib/security"
echo "install lib/security files"
if [ -z `basename $0` ]; then
    echo " - copying java security library files is skipped. clone this repository and run install.sh on local"
else
    if [ ! -f $SECURITY_DIR/US_export_policy.jar.bak ]; then
        cp $SECURITY_DIR/US_export_policy.jar $SECURITY_DIR/US_export_policy.jar.bak
        cp $SECURITY_DIR/local_policy.jar $SECURITY_DIR/local_policy.jar.bak
        cp "`dirname $0`/java-security-lib/US_export_policy.jar" $SECURITY_DIR
        cp "`dirname $0`/java-security-lib/local_policy.jar" $SECURITY_DIR
        echo " - installed"
    else
        echo " - already installed"
    fi
fi
