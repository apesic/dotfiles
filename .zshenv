# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

source ~/.liftoff_profile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PYTHONPATH="$REPOS/liftoff/workbench/python/liftoff:$PYTHONPATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PGDATA="/usr/local/var/postgres"
export NODE_PATH="/usr/local/lib/node_modules"
PERL_MB_OPT="--install_base \"/Users/apesic/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/apesic/perl5"; export PERL_MM_OPT;
export ANDROID_HOME=/Users/apesic/Library/Android/sdk/
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export KAFKA_DIR=$HOME/workbench/kafka
