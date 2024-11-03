# Extra
# ==============================================================================
# ==============================================================================
# ==============================================================================
# Use vi bindings
set -o vi

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	echo "Using existing SSH_ENV: ${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		echo "Found no ssh-agent process. Starting new SSH Agent"
        start_agent;
    }
else
	echo "Starting new SSH Agent"
    start_agent;
fi
# ==============================================================================
# ==============================================================================
# ==============================================================================

