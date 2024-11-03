# Eternal bash history across tmux panes
# ==============================================================================
# ==============================================================================
# ==============================================================================
# Do not put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
# Undocumented feature which sets the in-memory history size to "unlimited".
# REF: http://stackoverflow.com/questions/9457233/unlimited-bash-history
unset HISTSIZE
# Do not truncate history file
unset HISTFILESIZE
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# REF: http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_history_all
# Custom history format
export HISTTIMEFORMAT="[%F %T %Z] "
# After each command, append to the history file and reread it (persist history across tmux panes).
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# ==============================================================================
# ==============================================================================
# ==============================================================================
