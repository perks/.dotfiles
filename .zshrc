PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>/tmp/startlog.$$
    setopt xtrace prompt_subst
fi
# Load zgen
source "${HOME}/.zsh/zgen/zgen.zsh"

# Check if no init script
if ! zgen saved; then
  echo "Creating a zgen save"

  # Plugins
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load mafredri/zsh-async
  zgen load chrissicool/zsh-256color
  # Completions
  zgen load zsh-users/zsh-completions

  # Theme
  zgen load sindresorhus/pure

  # Save to init script
  zgen save
fi

autoload -U promptinit && promptinit
prompt pure

# autoload -Uz compinit
# compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case Insenstive
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd' # Better Kill
zstyle ':completion:*' menu select

# Speed up completion by avoiding partial globs.
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true

# Cache setup.
zstyle ':completion:*' use-cache on

# Separate directories from files.
zstyle ':completion:*' list-dirs-first true

# Separate matches into groups.
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' group-name ''

# Always use the most verbose completion.
zstyle ':completion:*' verbose true

# Treat sequences of slashes as single slash.
zstyle ':completion:*' squeeze-slashes true

# Describe options.
zstyle ':completion:*:options' description yes

# Completion presentation styles.
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[1m -- %d --\e[22m'
zstyle ':completion:*:messages'     format $'\e[1m -- %d --\e[22m'
zstyle ':completion:*:warnings'     format $'\e[1m -- No matches found --\e[22m'

# Ignore hidden files by default
zstyle ':completion:*:(all-|other-|)files'  ignored-patterns '*/.*'
zstyle ':completion:*:(local-|)directories' ignored-patterns '*/.*'
zstyle ':completion:*:cd:*'                 ignored-patterns '*/.*'

# Don't complete completion functions/widgets.
zstyle ':completion:*:functions' ignored-patterns '_*'
setopt listambiguous

# History
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt hist_ignore_all_dups
setopt hist_ignore_dups

##############################
# Key bidings
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Due to tmux being weird
# http://clock.co.uk/blog/zsh-ctrl-left-arrow-outputting-5d
bindkey "5C" forward-word
bindkey "5D" backward-word

zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Auto_cd magic
setopt auto_cd
setopt cshjunkiequotes
setopt correct
setopt histignoredups

#############
# Aliases
# ##########
alias ls='ls -hGF'
alias ll='ls -la'
alias l.='ls -d .*'
alias vim='nvim'
alias b='pushd +1 > /dev/null'
alias f='pushd -0 > /dev/null'

cd () {
if [ "$*" = "" ]; then
pushd $HOME >/dev/null
else
pushd "$*" >/dev/null
fi
}

alias lnpm='PATH=$(npm bin):$PATH' # Run local npm module always

killscreens () {
    screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
}
alias ctags="/usr/local/bin/ctags"

# Start FuzzyFinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_OPTS='--color=light'

# Start autojump
function j() {
  (( $+commands[brew] )) && {
    [[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh
    j "$@"
  }
}

# Load syntax for pyenv
function pyenv() {
  eval "$( command pyenv init -)"
  pyenv "$@"
}

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
  fi
