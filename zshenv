# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi


#alias ls='/usr/local/bin/gls'
export REPOS="$HOME/src"
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/opt/flutter/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
#export PYTHONPATH="$REPOS/liftoff/workbench/python/liftoff:$PYTHONPATH"
export PGDATA="/usr/local/var/postgres"
export NODE_PATH="/usr/local/lib/node_modules"
export ANDROID_HOME=$HOME/Android/Sdk/
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export KAFKA_DIR=$HOME/workbench/kafka
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export LEIN_REPL_PORT=7777
export GRAAL_HOME="/usr/local/graalvm/Contents/Home/"
#export JAVA_HOME="/usr/local/graalvm/Contents/Home/"
export PATH="/usr/local/graalvm/Contents/Home/bin:$PATH"
export PATH="/home/alexei/.platformio/penv/bin:$PATH"
export BAT_THEME="TwoDark"
export LIFTOFF_VENV_ROOT="$HOME/.venv"

export VIMWIKI_ROOT_PATH="$HOME/Sync/notes/"
export VIMWIKI_MARKDOWN_EXTENSIONS=nl2br,tables,codehilite,sane_lists,pymdownx.tasklist,pymdownx.b64,pymdownx.magiclink,pymdownx.superfences


if [[ -s ${HOME}/.localenv ]]; then
  source ${HOME}/.localenv
fi

export CHROME_EXECUTABLE="/opt/google/chrome/chrome"
