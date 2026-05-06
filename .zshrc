[[ $- != *i* ]] && return

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

bindkey '^[[D' backward-char
bindkey '^[[C' forward-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nmtui='NEWT_COLORS="$(<~/.config/nmtui/palette)" nmtui'
PS1='[\u@\h \W]\$ '

eval "$(starship init zsh)"
export EDITOR=nvim

export TMUX_CONF=~/.config/tmux/tmux.conf
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias sp='sudo pacman'
alias spua='sudo pacman -Syu'
alias integrated='sudo envycontrol -s integrated'
alias hybrid='sudo envycontrol -s hybrid'
alias curseforge='prime-run curseforge'

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U  compinit && compinit

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

eval "$(fzf --zsh)"
