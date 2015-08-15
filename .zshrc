# I hate 256 color
~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

fpath=(/usr/local/share/zsh-completions $fpath)

# Start prompts
setopt prompt_subst
# Pure Prompt
autoload -U promptinit
promptinit

# Initialize colors
# Necessary for
#     $ echo "$fg[blue] hello world"
# Like is uesd in zsh-colors
autoload -U colors
colors

# Default colors for listings.
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=00}:${(s.:.)LS_COLORS}")';
##############################
# Key bidings
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Due to tmux being weird
# http://clock.co.uk/blog/zsh-ctrl-left-arrow-outputting-5d
bindkey "5C" forward-word
bindkey "5D" backward-word

# Tab Completion
autoload -Uz compinit
compinit

# Enable Ctrl-x-e edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey 'jk' edit-command-line
bindkey '^xe' edit-command-line

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

zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Auto_cd magic
setopt auto_cd

#############
# Aliases
# ##########
alias ls='ls -hGF'
alias ll='ls -la'
alias l.='ls -d .*'
alias vim='mvim -v'

alias lnpm='PATH=$(npm bin):$PATH' # Run local npm module always

killscreens () {
    screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
}
alias ctags="`brew --prefix`/bin/ctags"

source ~/.zsh/antigen-hs/init.zsh

# Start FuzzyFinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--color=light'

# Start autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# Load syntax for pyenv
eval "$(pyenv init -)"


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
