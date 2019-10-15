# Set standard path
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

# More paths
export PATH=$PATH:/usr/X11/bin
export PATH=$HOME/.dotfiles/bin:$PATH

# Environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Base16 Shell
BASE16_SHELL="$HOME/.dotfiles/base16/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Disable ZSH autocorrect
unsetopt CORRECT
setopt CLOBBER

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
alias gco='git checkout'
alias gca='git commit -va'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gb='git branch'
alias ga='git add'
alias gaa='git add --all :/'
alias gr='git -c commit.verbose=true rebase'
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

pwned() {
    echo "Password:"
    read PW
    K_ANON_PREFIX=$(echo -n $PW | shasum | cut -b 1-5)
    K_ANON_SUFFIX=$(echo -n $PW | shasum | tr '[:lower:]' '[:upper:]' | cut -d ' ' -f 1 | cut -b 6-)
    unset PW

    echo "has been seen:"
    curl -s https://api.pwnedpasswords.com/range/$K_ANON_PREFIX \
        | grep $K_ANON_SUFFIX \
        | cut -d : -f 2 | xargs
    echo "times."
    unset K_ANON_SUFFIX
    unset K_ANON_PREFIX
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

# Golang default GOPATH
export GOPATH=$HOME/.gopath
export PATH=$GOPATH/bin:$PATH

# Kubernetes log watcher
kubelogwatch() {
    namespace=$1
    app=$2
    cmd="bash -c \"kubectl -n $namespace logs --timestamps --tail=\$LINES -l app=$app | sort | fold -w \$COLUMNS - | tail -n \$((\$LINES - 3))\""
    watch -n 2 $cmd
}
