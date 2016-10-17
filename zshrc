# Set standard path
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

# More paths
export PATH=$PATH:/usr/X11/bin
export PATH=$HOME/.dotfiles/bin:$PATH

# Environment
export LANG=en_US.UTF-8
export EDITOR=vim
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Disable ZSH autocorrect
unsetopt CORRECT

# Helpers
alias reload="source ~/.zshrc"
alias please='eval "fc -lnr | head -n 1" | xargs sudo'

# Shortcuts
alias l='ls -l'
alias ll='ls -la'

alias py=python
alias ip=ipython

alias g='git'
alias gc='git commit -v'
alias gca='git commit -va'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gaa='git add --all :/'
alias gr='git rebase'
alias gs='git stash -u'
alias gst='git status'
alias gsp='git stash pop'

# Practical functions
repeatedly() {
    while true;
    do
        "$@"
        echo "> Hit return to execute:"
        echo ">" "$@"
        read
        clear
    done
}

agblame() {
    query="$1"
    ag "$query" | (while read line; do (export f="$(echo $line | cut -d : -f 1)"; export l="$(echo $line | cut -d : -f 2)"; git --no-pager blame $f -L $l,+1); done) | grep "$query"
}

# OS Specific Config
if [ "$(uname)" = "Darwin" ]; then
    source $HOME/.zshrc.mac
fi
if [ "$(uname)" = "Linux" ]; then
    source $HOME/.zshrc.linux
fi

# Load per-hostname-specific ZSH config
#HOSTCFG=$HOME/.zshrc.$(hostname)
#if [ -e $HOSTCFG ]; then
#    source $HOSTCFG
#fi

test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
