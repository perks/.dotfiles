
 if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
 fi
# Begin aliases:

#List functions
alias ls='ls -GFh'
alias ll='ls -la'
alias l.='ls -d .*'
alias vim='mvim -v'
alias e='subl . &'


#cd behavior
alias ..='cd ..'

#run local npm module always
alias lnpm='PATH=$(npm bin):$PATH'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

source ~/.bash_prompt
bash_prompt
unset bash_prompt

export PATH=/usr/local/bin:/usr/local/lib/node_modules/karma/bin:$PATH

export NODE_PATH=/usr/local/lib/node_modules

export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"


# Load RVM into shell session *as a function*

PATH=$PYENV_ROOT/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# OPAM ocaml stuff
/Users/Chris/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Load RVM into a shell session *as a function*

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
