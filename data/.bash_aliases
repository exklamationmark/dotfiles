# ls aliases
alias ll='ls -alF'



# useful for shortcuts
alias startcoding='cd ~/workspace/src'

add.ssh_keys() { # add ssh keys
}


# git
alias gitka='gitk --all'                  # view all commits & branches on gitk
alias gdiff='git diff --color-words --no-index'              # colored git diff
alias less='less -r'



# Docker
cleanup.docker.exited.containers() {
	docker rm `docker ps -a | grep Exited | awk '{print $1}'`
}
cleanup.docker.orphan.images() {
	docker rmi `docker images | grep none | awk '{print $3}'`
}
cleanup.docker.all.images() {
	docker rmi -f `docker images | grep -v REPO | awk '{print $3}' | sort | uniq`
}
dk() {
	local cmd=$1
	local pattern=$2
	local params=${@:3}
	local dockerID=$(docker ps -a | grep $pattern | awk '{print $1}')

	case $cmd in
	ip)
		docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $dockerID
		;;
	sh)
		echo "docker exec -it $dockerID /bin/sh"
		docker exec -it $dockerID /bin/sh
		;;
	bash)
		echo "docker exec -it $dockerID /bin/bash"
		docker exec -it $dockerID /bin/bash
		;;
	logs)
		echo "docker logs $dockerID $params"
		docker logs $dockerID $params
		;;
	esac
}


# Neovim
# vim() {
# 	nvim $@
# }



# Pandoc
render.markdown() {
	# Need: pip3 install grip
	if [ "$#" -lt 1 ]; then
		local filename="README.md"
	else
		local filename=$1
	fi

	pandoc $filename > /tmp/markdown.html
	w3m -T text/html /tmp/markdown.html
}


# xclip
xc() { # pipe to clipboard, e.g: <command> | xc
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
xcf() { # copy file content to clipboard, e.g: xcf <file>
	cat "$1" | xc;
}

# PlantUML run the PlantUML container built in https://github.com/bitsgofer/plantuml
render.plantuml() {
	local INPUT_UML_FILE=${1}
	local OUTPUT_SVG_FILE=${2}

	local plantUML_image=bitsgofer/plantuml:1.2022.3

	docker run --rm -i ${plantUML_image} < ${INPUT_UML_FILE} > ${OUTPUT_SVG_FILE}
}
