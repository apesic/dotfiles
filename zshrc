COMPLETION_WAITING_DOTS="true"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
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
#bindkey "^O" forward-word
#bindkey "^I" backward-word
export KEYTIMEOUT=1

unsetopt correct_all

# History
setopt INC_APPEND_HISTORY        # save history as commands are entered, not when shell exits
setopt HIST_IGNORE_DUPS          # don't save duplicate commmands in history
unsetopt HIST_IGNORE_SPACE       # do save commands that begin with a space
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.
HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zhistory}"  # The path to the history file.
HISTSIZE=50000                   # The maximum number of events to save in the internal history.
SAVEHIST=50000                   # The maximum number of events to save in the history file.

# Directory
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.

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
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '𝌆'
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""
zstyle ':vcs_info:git*' formats ' %F{8}%b %F{blue}%%u%c%f'
zstyle ':vcs_info:git*' actionformats ' %F{8}%b %F{blue}%%u%c%f |%F{yellow}%a%f'
FORCE_RUN_VCS_INFO=1

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
repo_information() {
    echo "${vcs_info_msg_0_} %F{yellow}`git_dirty`%f"
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
    local preprompt="\n%F{8}┏━ %f%F{blue}%~%F{242}%F{242}`repo_information` %F{yellow}`cmd_exec_time`%f"
	print -P $preprompt

	# check async if there is anything to pull
	(( ${PURE_GIT_PULL:-1} )) && {
		# check if we're in a git repo
		command git rev-parse --is-inside-work-tree &>/dev/null &&
		# check check if there is anything to pull
		command git fetch &>/dev/null &&
		# check if there is an upstream configured for this branch
		command git rev-parse --abbrev-ref @'{u}' &>/dev/null && {
			local gs=''
			local ahead behind
			ahead=$(git rev-list --right-only --count HEAD...@'{u}')
			behind=$(git rev-list --left-only --count HEAD...@'{u}')
			(( $ahead > 0 )) && gs='↓'
			(( $ahead > 1 )) && gs+='%F{8}${ahead}%f'
			(( $behind > 0 )) && gs+='↑'
			(( $behind > 1 )) && gs+='%F{8}${behind}%f'
			print -Pn "\e7\e[A\e[1G\e[`prompt_string_length $preprompt`C%F{cyan}${gs}%f\e8"
		}
	} &!

	# reset value since `preexec` isn't always triggered
	unset cmd_timestamp
}

function insert-mode () { echo "%F{8}┗━%f" }
function normal-mode () { echo "%F{8}┗┿%f" }

function set-prompt () {
  case ${KEYMAP} in
    (vicmd)      VI_MODE="$(normal-mode)" ;;
    (main|viins) VI_MODE="$(insert-mode)" ;;
    (*)          VI_MODE="$(insert-mode)" ;;
  esac
  PROMPT="$VI_MODE%(?.%F{magenta}.%F{red})❯❯%f " # Display a red prompt char on failure
  RPROMPT="%F{8}$(date '+%H:%M:%S %m-%d-%y')%f"
}

function zle-line-init zle-keymap-select() {
  set-prompt
  zle reset-prompt
}

# prevent percentage showing up
# if output doesn't end with a newline
export PROMPT_EOL_MARK=''

prompt_opts=(cr subst percent)

zmodload zsh/datetime
autoload -Uz add-zsh-hook

add-zsh-hook precmd prompt_precmd
add-zsh-hook preexec prompt_preexec

zle -N zle-line-init
zle -N zle-keymap-select

# ------------------------------------------------------------------------------
#
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

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
#
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit light-mode for \
  wookayin/fzf-fasd \
  wfxr/forgit \
  Aloxaf/fzf-tab \
  apesic/znotes

export FORGIT_FZF_DEFAULT_OPTS="--ansi
--height='80%'
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='ctrl-s:toggle-sort'
--bind='?:toggle-preview'
--bind='alt-w:toggle-preview-wrap'
--preview-window='right:60%'
--reverse
"

# znotes
zstyle :notes home '/Users/apesic/Sync/notes'
bindkey '^N' notes-pick-widget

# navi - cheatsheets
source <(echo "$(navi widget zsh)")
export NAVI_FZF_OVERRIDES="--reverse --height 20"

# smartcase matching
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
