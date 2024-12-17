# Golang
# ==============================================================================
# ==============================================================================
# ==============================================================================
export PATH=$HOME/.krew/bin:$PATH

k.set.ns() {
	local namespace=$1
	kubectl config set-context $(kubectl config current-context) --namespace=${namespace}
}

k() {
	kubectl $@
}

kk() {
	local command=$1
	local selector=$2
	# local resource_type=$2
	# local pattern=$3
	local params=${@:3}

	# grab the first resource
	local resource_type=$(echo "${selector}" | awk -F '/' '{print $1}')
	local pattern=$(echo "${selector}" | awk -F '/' '{print $2}')
	local target=$(kubectl get ${resource_type} | grep ${pattern} | head -n 1 | awk '{print $1'})
	if [ -z "${target}" ]
	then
		echo "Found no ${resource_type} matching \"${pattern}\""
		return
	fi

	case ${command} in
		desc)
			command="describe"
		;;
		execit)
			command="exec -it"
		;;
		bash)
			command="exec -it"
			params="/bin/bash"
		;;
		sh)
			command="exec -it"
			params="/bin/sh"
		;;
	esac

	kubectl ${command} ${resource_type}/${target} ${params}
}

source <(kubectl completion bash | sed -e 's|kubectl|k|g')

# Kubernetes in Docker (kind)
kind.create.simple.cluster() {
	kind create cluster \
		--config=${HOME}/.kube/kind_1_node_cluster.yaml \
		--kubeconfig=${HOME}/.kube/kind.config
}
kind.create.big.cluster() {
	kind create cluster \
		--config=${HOME}/.kube/kind_3_node_cluster.yaml \
		--kubeconfig=${HOME}/.kube/kind.config
}
source <(kind completion bash)
kind_cluster.load_img() {
	local cluster_name=$1
	local img=$2
	kind --name ${cluster_name} load docker-image ${img}
}

install_kubectl() {
	latest=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
	local pwd=$(pwd)
	local tmp=$(mktemp)
	cd $tmp
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$latest/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl

	cd $pwd
	rm -rf $tmp
}

install_kind() {
	local pwd=$(pwd)
	local tmp=$(mktemp)
	cd $tmp
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind

	cd $pwd
	rm -rf $tmp
}

install_krew() {
	set -x
	cd "$(mktemp -d)" && \
		OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
		ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
		KREW="krew-${OS}_${ARCH}" && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" && \
		tar zxvf "${KREW}.tar.gz" && \
		./"${KREW}" install krew
}

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# export DOCKER_BUILDKIT=0
# ==============================================================================
# ==============================================================================
# ==============================================================================

