# PS1 (custom prompt)
# ==============================================================================
# ==============================================================================
# ==============================================================================
# git's bash completion
if [ -f /etc/bash_completion.d/git-completion.bash ]; then
	. /etc/bash_completion.d/git-completion.bash;
fi

_current_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | tr -d ' '
}

_current_k8s_context() {
	local context_name=$(kubectl config view -o json | jq -r '."current-context"')
	if [ -z "${context_name}" ]; then
		echo "(NONE)"
		return 0
	fi
	local namespace=$(kubectl config view -o json | jq -r '.contexts[] | select (.name | contains("'"$context_name"'")).context.namespace')

	echo "($context_name/$namespace)"
}

PROMPT_COLOR_RED='\[\033[31m\]'
PROMPT_COLOR_GREEN='\[\033[32m\]'
PROMPT_COLOR_YELLOW='\[\033[33m\]'
PROMPT_COLOR_BLUE='\[\033[34m\]'
PROMPT_COLOR_MAGENTA='\[\033[35m\]'
PROMPT_COLOR_NONE='\[\033[0m\]'
export PS1="\n$PROMPT_COLOR_MAGENTA\! $PROMPT_COLOR_GREEN\u@\h $PROMPT_COLOR_BLUE\D{%F %T %Z} $PROMPT_COLOR_NONE\W$PROMPT_COLOR_BLUE git:\$(_current_git_branch)$PROMPT_COLOR_YELLOW k8s:\$(_current_k8s_context) $PROMPT_COLOR_NONE$\r\n"
# ==============================================================================
# ==============================================================================
# ==============================================================================
