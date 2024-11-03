# Golang
# ==============================================================================
# ==============================================================================
# ==============================================================================
export GOPATH="$HOME/workspace"
export PATH=$GOPATH/bin:/usr/local/go/bin:/usr/local/kubebuilder/bin:$PATH

# Aliases / functions leveraging the cb() function
test.color() {
	sed -u -r "
		s#PASS#`printf "\033[32m"`PASS`printf "\033[0m"`#g
		s#FAIL#`printf "\033[31m"`FAIL`printf "\033[0m"`#g
		s#\"(config|app|group|msg|keyspace)\":#\"`printf "\033[37m"`\1`printf "\033[0m"`\":#g
		s#\"(namespace|subsystem)\":#\"`printf "\033[1;34m"`\1`printf "\033[0m"`\":#g
		s#\"(event)\":#\"`printf "\033[34m"`\1`printf "\033[0m"`\":#g
		s#\"(level)\":#\"`printf "\033[35m"`\1`printf "\033[0m"`\":#g
		s#\"(error)\":#\"`printf "\033[31m"`\1`printf "\033[0m"`\":#g
		s#\"(warn)\":#\"`printf "\033[33m"`\1`printf "\033[0m"`\":#g
		s#\"(test)\":#\"`printf "\033[36m"`\1`printf "\033[0m"`\":#g
		s#\"(ts)\":#\"`printf "\033[1;35m"`\1`printf "\033[0m"`\":#g
		s#\"(from)\":#\"`printf "\033[34m"`\1`printf "\033[0m"`\":#g
	"
}

test.all() {
	go test -race -v | test.color
}

godoc.server() {
	godoc --http=0.0.0.0:10666
}

gotool.cover() {
	local COVERAGE_FILE=${1:-cover.out}
	local COVERGAGE_HTML="/tmp/coverage.html"

	go tool cover -html=${COVERAGE_FILE} -o ${COVERGAGE_HTML}
	google-chrome ${COVERGAGE_HTML}
}
# ==============================================================================
# ==============================================================================
# ==============================================================================

