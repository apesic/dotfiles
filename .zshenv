# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

alias ls='/usr/local/bin/gls'
source ~/.liftoff_profile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PYTHONPATH="$REPOS/liftoff/workbench/python/liftoff:$PYTHONPATH"
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PGDATA="/usr/local/var/postgres"
export NODE_PATH="/usr/local/lib/node_modules"
PERL_MB_OPT="--install_base \"/Users/apesic/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/apesic/perl5"; export PERL_MM_OPT;
export ANDROID_HOME=/Users/apesic/Library/Android/sdk/
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export KAFKA_DIR=$HOME/workbench/kafka
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export BASE_DIR='/Users/apesic/kafka'
export KAFKA_DIR="$BASE_DIR/kafka"
export LEIN_REPL_PORT=7777
