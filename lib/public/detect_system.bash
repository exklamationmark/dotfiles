# OS and ARCH detection
_os="$(uname -s)"
_arch="$(uname -m)"
# OS: linux, darwin
OS="UNDEFINED"
# ARCH: amd64, arm64
ARCH="UNDEFINED"
# LINUX_DISTRO: ubuntu, debian, fedora, arch
LINUX_DISTRO="UNDEFINED"
case "${_os}" in
	Linux*) 
		OS="linux"
		_distro="$(lsb_release -is)"
		case "${_distro}" in
			Ubuntu*)	LINUX_DISTRO="ubuntu" ;;
			Debian*)	LINUX_DISTRO="debian" ;;
			Fedora*)	LINUX_DISTRO="fedora" ;;
			Arch*)		LINUX_DISTRO="arch" ;;
			*) 		error "Unsupported Linux distro: ${_distro}." ;;
		esac
		;;
	Darwin*) 	OS="darwin" ;;
	*)		error "Unsupported OS: ${_os}. On Windows, run in WSL." ;;
esac
case "${_arch}" in
	x86_64*)	ARCH="amd64" ;;
	*)		error "Unsupported ARCH: ${_arch}." ;;
esac

# WSL: true, false
WSL=false
if [ "${OS}" = "linux" ] && grep -qi microsoft /proc/version 2>/dev/null; then
	WSL=true
	info "WSL detected"
fi
highlight "Detected: ARCH=${ARCH}; OS=${OS}; LINUX_DISTRO=${LINUX_DISTRO}; WSL=${WSL}."


