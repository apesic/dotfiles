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
autoload -U edit-command-line # We want to use 'v' in normal mode to edit and execute like in bash vi mode
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
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

function emacs (){
  emacsclient "$@" 2>/dev/null || /usr/bin/emacs "$@"
}

# PROMPT
#
# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
#
repo_information() {
    echo "%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

# Displays the exec time of the last command if set threshold was exceeded
#

# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
prompt_human_time() {
	local tmp=$1
	local days=$(( tmp / 60 / 60 / 24 ))
	local hours=$(( tmp / 60 / 60 % 24 ))
	local minutes=$(( tmp / 60 % 60 ))
	local seconds=$(( tmp % 60 ))
	(( $days > 0 )) && echo -n "${days}d "
	(( $hours > 0 )) && echo -n "${hours}h "
	(( $minutes > 0 )) && echo -n "${minutes}m "
	echo "${seconds}s"
}

cmd_exec_time() {
	local stop=$EPOCHSECONDS
	local start=${cmd_timestamp:-$stop}
	integer elapsed=$stop-$start
	(($elapsed > ${PURE_CMD_MAX_EXEC_TIME:=5})) && prompt_human_time $elapsed
}

# Get the intial timestamp for cmd_exec_time
#
prompt_preexec() {
  cmd_timestamp=`date +%s`

	# shows the current dir and executed command in the title when a process is active
	print -Pn "\e]0;"
	echo -nE "$PWD:t: $2"
	print -Pn "\a"
}

# string length ignoring ansi escapes
prompt_string_length() {
	echo ${#${(S%%)1//(\%([KF1]|)\{*\}|\%[Bbkf])}}
}

# Output additional information about paths, repos and exec time

prompt_precmd() {
  vcs_info # Get version control info before we start outputting stuff
  #print -P "\n%F{8}┏━ %f$(repo_information) %F{yellow}$(cmd_exec_time)%f"

	local preprompt="\n%F{8}┏━ %f%F{blue}%~%F{242}$vcs_info_msg_0_`git_dirty` %f %F{yellow}`cmd_exec_time`%f"
	print -P $preprompt

	# check async if there is anything to pull
	(( ${PURE_GIT_PULL:-1} )) && {
		# check if we're in a git repo
		command git rev-parse --is-inside-work-tree &>/dev/null &&
		# check check if there is anything to pull
		command git fetch &>/dev/null &&
		# check if there is an upstream configured for this branch
		command git rev-parse --abbrev-ref @'{u}' &>/dev/null && {
			local arrows=''
			(( $(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows='↓'
			(( $(command git rev-list --left-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows+='↑'
			print -Pn "\e7\e[A\e[1G\e[`prompt_string_length $preprompt`C%F{cyan}${arrows}%f\e8"
		}
	} &!

	# reset value since `preexec` isn't always triggered
	unset cmd_timestamp
}

#terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
function insert-mode () { echo "%F{8}┗━%f" }
function normal-mode () { echo "%F{8}┗┿%f" }

function set-prompt () {
  case ${KEYMAP} in
    (vicmd)      VI_MODE="$(normal-mode)" ;;
    (main|viins) VI_MODE="$(insert-mode)" ;;
    (*)          VI_MODE="$(insert-mode)" ;;
  esac
  PROMPT="$VI_MODE%(?.%F{magenta}.%F{red})❯❯%f " # Display a red prompt char on failure
  RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"    # Display username if connected via SSH
}

function zle-line-init zle-keymap-select() {
  set-prompt
  zle reset-prompt
}

#preexec () { print -rn -- $terminfo[el]; }
#
# prevent percentage showing up
# if output doesn't end with a newline
export PROMPT_EOL_MARK=''

prompt_opts=(cr subst percent)

zmodload zsh/datetime
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd prompt_precmd
add-zsh-hook preexec prompt_preexec

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %b'
zstyle ':vcs_info:git*' actionformats ' %b|%a'
zle -N zle-line-init
zle -N zle-keymap-select

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
