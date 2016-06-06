# This variable is appended to in each sub-.zshrc-file that's sourced. Use
# it to see which files got loaded: $ echo $ZSHRCLOADS
export ZSHRCLOADS=".zshrc"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm-simlun"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python autojump)

source $ZSH/oh-my-zsh.sh
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH

# Global Config
source $HOME/.zshrc.global

# OS Specific Config
if [ "$(uname)" = "Darwin" ]; then
    source $HOME/.zshrc.mac
fi
if [ "$(uname)" = "Linux" ]; then
    source $HOME/.zshrc.linux
fi

# Hostname Specific Config
HOSTNAME=$(hostname)

# Special case for KTH hostnames
IS_IT_A_KTH_HOSTNAME=$(hostname | grep "kthopen.kth.se" | wc -l | cut -d ' ' -f 8)
if [ "$IS_IT_A_KTH_HOSTNAME" -eq "1" ]; then
    HOSTNAME="simonl-air.local"
fi

# Load per-hostname-specific ZSH config
HOSTCFG=$HOME/.zshrc.$HOSTNAME
if [ -f $HOSTCFG ]; then
    source $HOSTCFG
fi
