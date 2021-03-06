# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#alias ls='/usr/local/bin/gls'
export REPOS="$HOME/src"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$REPOS/flutter/bin:$PATH"
export PYTHONPATH="$REPOS/liftoff/workbench/python/liftoff:$PYTHONPATH"
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
export GRAAL_HOME="/usr/local/graalvm/Contents/Home/"
#export JAVA_HOME="/usr/local/graalvm/Contents/Home/"
export PATH="/usr/local/graalvm/Contents/Home/bin:$PATH"
export BAT_THEME="TwoDark"
export LIFTOFF_VENV_ROOT="$HOME/.venv"

export PYTHONUTILSPATH=$REPOS/liftoff/datascience/python/src
[[ ":$PYTHONPATH:" != *":${PYTHONUTILSPATH}:"* ]] && PYTHONPATH="${PYTHONUTILSPATH}:${PYTHONPATH}"


if [[ -s ${HOME}/.localenv ]]; then
  source ${HOME}/.localenv
fi

if [[ -s ${HOME}/.liftoff_profile ]]; then
  source ${HOME}/.liftoff_profile
fi
