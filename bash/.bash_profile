# .bash_profile

export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

export GOBIN=$HOME/.local/bin
export PATH=$PATH:$GOBIN

export GO111MODULE=on

export CARGO_HOME=$HOME/.cargo/bin/bin
export PATH=$PATH:$CARGO_HOME

export ENYE="ñ, Ñ"
export ACCENTED_VOWELS="á, é, í, ó, ú"


export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a 'emacs'"

export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="$HOME/.sdkman"

# Get the aliases and functions
#if [ -f ~/.bashrc ]; then
#	. ~/.bashrc
#fi
