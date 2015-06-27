if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f /opt/local/etc/bash_completion ]; then
      . /opt/local/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session

alias ls = "ls -G"
