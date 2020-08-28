# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

COMPLETION_WAITING_DOTS="true"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

eval "$(fasd --init zsh-hook zsh-wcomp-install zsh-wcomp posix-alias)"

source ~/.aliases

eval "$(rbenv init -)"

# Needed in Sierra to re-init ssh agent in each session
{ eval `ssh-agent`; ssh-add -A; } &>/dev/null

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Vi mode!
bindkey -v
bindkey "^?" backward-delete-char                # Allow for deleting characters in vi mode
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
export KEYTIMEOUT=1

unsetopt correct_all
setopt INC_APPEND_HISTORY  # save history as commands are entered, not when shell exits
setopt HIST_IGNORE_DUPS    # don't save duplicate commmands in history
unsetopt HIST_IGNORE_SPACE # do save commands that begin with a space

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd -c always'
export FZF_CTRL_T_COMMAND='fd -c always'
export FZF_CTRL_T_OPTS="--ansi --preview '(bat -n --color always --wrap character {} 2> /dev/null || cat {} || exa -Ta --group-directories-first --level 2 --git --color=always --icons {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--ansi --preview '(exa -Ta --level 2 --git --color=always {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {} | bat -n --color always --wrap character -p -l bash' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

function httpl {
    http --pretty=all --print=hb "$@" | less -R;
}
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

# PROMPT
eval "$(starship init zsh)"

