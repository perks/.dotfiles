############
# Env and Paths
# #########

# Editor

export EDITOR='nvim'
export VISUAL='nvim'

export NODE_PATH=/usr/local/lib/node_modules

export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

export PYENV_ROOT="$HOME/.pyenv"

# Cabal and GHC
PATH=$HOME/Library/Haskell/bin:$PATH

# OPAM ocaml stuff
#~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Export Path
export PATH=/usr/local/bin:$PATH
export WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh

export LPASS_AGENT_TIMEOUT=0

if [[ $TMUX =~ tmate ]]; then alias tmux=tmate; fi

export FZF_TMUX_HEIGHT=10
# Functions that run in tmux splits
if [[ -n $TMUX ]]; then

  # Function to open fzf searches in tmux split
  fzf-tmux-split () {
    tmux split-window -v -l $FZF_TMUX_HEIGHT \
      "zsh -c 'source ~/.zsh/fzf.zsh; tmux send-keys -t $TMUX_PANE \"\$(${1})\"'"
  }

  fl_t () {
    fzf-tmux-split fl
  }
  zle -N fl_t
  bindkey -e '^f' fl_t

  fzd_t () {
    fzf-tmux-split fzd
  }
  zle -N fzd_t
  bindkey -e '^z' fzd_t

  fkill_t () {
    fzf-tmux-split fkill
  }
  zle -N fkill_t
  bindkey -e '^k' fkill_t

  ftpane () {
    local pane_format panes current_pane current_window target target_window target_pane
    pane_format='#I:#P - #{pane_current_path} #{pane_current_command}'
    current_pane=$(tmux display-message -p $pane_format)
    current_window=$(tmux display-message -p '#I')

    panes=$(tmux list-panes -s -F $pane_format | grep -v "^${current_pane}")

    target=$(echo $panes | fzf -1)

    target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
    target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

    if [[ $current_window -eq $target_window ]]; then
      tmux select-pane -t ${target_window}.${target_pane}
    else
      tmux select-pane -t ${target_window}.${target_pane} &&
      tmux select-window -t $target_window
    fi
  }
  ftpane_t () {
    if [[ $(tmux list-panes -s | wc -l) -gt 1 ]]; then
      fzf-tmux-split ftpane
    fi
  }
  zle -N ftpane_t
  bindkey -e '^t' ftpane_t

fi
