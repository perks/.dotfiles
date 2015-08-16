############
# Env and Paths
# #########

# Editor

export EDITOR='vim'
export VISUAL='vim'

export NODE_PATH=/usr/local/lib/node_modules

export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

# Load RVM into shell session as function

export PYENV_ROOT="$HOME/.pyenv"

# Cabal and GHC
PATH=$HOME/Library/Haskell/bin:$PATH

# OPAM ocaml stuff
~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Export Path
export PATH=/usr/local/bin:$PATH
export WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh
