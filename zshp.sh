 if ! grep -q "plugins=\(git\)" ~/.zshrc; then
     echo "Task: settings for zsh plugins"
     sed -i '' -e 's/plugins=(git)/plugins=(git autojump)/' ~/.zshrc
 fi
