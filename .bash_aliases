# add color to grep result
alias grep='grep --color=auto'

# coding "ritual"
alias startcoding='cd ~/workspace/src'

# timing commands
alias xtime="/usr/bin/time -f '%Uu %Ss %er %MkB %C' \"$@\""

# view all commits & branches on gitk
alias gitka='gitk --all'

# colored git diff
alias gdiff='git diff --color-words --no-index'

# docker cleanup
cleanup.docker.exited.containers() {
	docker rm `docker ps -a | grep Exited | awk '{print $1}'`
}
cleanup.docker.orphan.images() {
	docker rmi `docker images | grep none | awk '{print $3}'`
}

godoc.server() {
	godoc --http=0.0.0.0:10666
}

dk() {
	local cmd=$1
	local pattern=$2
	local params=${@:3}
	local dockerID=$(docker ps -a | grep $pattern | awk '{print $1}')

	case $cmd in
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
