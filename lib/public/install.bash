#!/bin/bash

# helpers
# ==============================================================================
is_deb_package_installed() {
	local package=$1

	if dpkg --get-selections | grep -q "^${package}[[:space:]]*install$" >/dev/null
	then
		return 0
	fi
	return 1
}

is_ppa_installed() {
	local ppa=$1

	if ls -alF /etc/apt/sources.list.d/ | grep -q "[[:space:]]${ppa}\.list$" >/dev/null
	then
		return 0
	fi
	return 1
}

install_deb_from_url() {
	local deb_package=$1
	local url=$2

	if [[ -n "$url" ]]
	then
		curl $url > /tmp/${deb_package}.deb
	fi
	sudo apt install /tmp/${deb_package}.deb -y
}

# Google Chrome PPA
# ==============================================================================
add_google_chrome_ppa_linux_ubuntu() {
	local ppa="google-chrome"
	local signing_key_url="https://dl.google.com/linux/linux_signing_key.pub"
	local ppa_url="https://dl.google.com/linux/chrome/deb/"
	local pgp_public_key="/etc/apt/keyrings/${ppa}.asc"

	if is_ppa_installed ${ppa}
	then
		highlight "Already added PPA: ${ppa}."
		return 0
	fi

	wget -q -O - ${signing_key_url} | sudo tee ${pgp_public_key} >/dev/null
	echo "deb [arch=amd64 signed-by=${pgp_public_key}] ${ppa_url} stable main" | sudo tee /etc/apt/sources.list.d/${ppa}.list >/dev/null

	info "Added PPA: ${ppa} (${ppa_url})."
}

# Google Chrome
# ==============================================================================
install_google_chrome() {
	# abstraction over ${OS}/${ARCH}/${LINUX_DISTRO}
	return 0
}

install_google_chrome_linux_ubuntu() {
	local package="Google Chrome"
	local deb_package="google-chrome-stable"

	if is_deb_package_installed ${deb_package}
	then
		highlight "Already installed: ${package}."
		return 0
	fi

	info "Installing ${package} (${deb_package})..."
	# Assume called: add_google_chrome_ppa_linux_ubuntu && sudo apt update
	sudo apt install ${deb_package} -y

	highlight "Installed: ${package} (apt: ${deb_package})."
}

# Mozilla PPA
# ==============================================================================
add_mozilla_ppa_linux_ubuntu() {
	local ppa="mozilla"
	local signing_key_url="https://packages.mozilla.org/apt/repo-signing-key.gpg"
	local ppa_url="https://packages.mozilla.org/apt/"
	local pgp_public_key="/etc/apt/keyrings/${ppa}.asc"
	
	if is_ppa_installed ${ppa}
	then
		highlight "Already added PPA: ${ppa}."
		return 0
	fi

	wget -q -O - ${signing_key_url} | sudo tee ${pgp_public_key} >/dev/null
	echo "deb [signed-by=${pgp_public_key}] ${ppa_url} mozilla main" | sudo tee /etc/apt/sources.list.d/${ppa}.list >/dev/null
	echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/${ppa} >/dev/null

	info "Added PPA: ${ppa} (${ppa_url})."
}

# Firefox
# ==============================================================================
install_firefox() {
	# abstraction over ${OS}/${ARCH}/${LINUX_DISTRO}
	return 0
}

install_firefox_linux_ubuntu() {
	local package="Firefox"
	local deb_package="firefox"
	
	# Remove snap & default version of Firefox.
	# This always need to happen, to ensure we use the package from PPA.
	#
	# NOTE: Can comment out while updating the script.
	sudo snap remove --purge --terminate ${deb_package}
	sudo apt remove ${deb_package} --purge -y

	if is_deb_package_installed ${deb_package}
	then
		highlight "Already installed: ${package}."
		return 0
	fi

	info "Installing ${package} (${deb_package})..."
	# Assume called: add_mozilla_ppa_linux_ubuntu && sudo apt update
	sudo apt install ${deb_package} -y

	highlight "Installed: ${package} (apt: ${deb_package})."
}

# 1Pasword PPA
# ==============================================================================
add_1password_ppa_linux_ubuntu() {
	local ppa="1password"
	local signing_key_url="https://downloads.1password.com/linux/keys/1password.asc"
	local ppa_url="https://downloads.1password.com/linux/debian/amd64"
	local pgp_public_key="/usr/share/keyrings/1password-archive-keyring.gpg"
	local debsig_policy_url="https://downloads.1password.com/linux/debian/debsig/1password.pol"
	
	if is_ppa_installed ${ppa}
	then
		highlight "Already added PPA: ${ppa}."
		return 0
	fi

	wget -q -O - ${signing_key_url} | sudo gpg --dearmor --output ${pgp_public_key} >/dev/null
	echo "deb [arch=amd64 signed-by=${pgp_public_key}] ${ppa_url} stable main" | sudo tee /etc/apt/sources.list.d/${ppa}.list >/dev/null
	
	# Additional debsig-verify policy
	# (https://support.1password.com/install-linux/#debian-or-ubuntu)
 	sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
 	wget -q -O - ${debsig_policy_url}  | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol >/dev/null
 	sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
 	wget -q -O - ${signing_key_url} | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg >/dev/null

	info "Added PPA: ${ppa} (${ppa_url})."
}

# 1Password
# ==============================================================================
install_1password() {
	# abstraction over ${OS}/${ARCH}/${LINUX_DISTRO}
	return 0
}

install_1password_linux_ubuntu() {
	local package="1Password"
	local deb_package="1password"

	if is_deb_package_installed ${deb_package}
	then
		highlight "Already installed: ${package}."
		return 0
	fi

	info "Installing ${package} (${deb_package})..."
	# Assume called: add_1password_ppa_linux_ubuntu && sudo apt update
	sudo apt install ${deb_package} -y

	highlight "Installed: ${package} (apt: ${deb_package})."
}

wait_for_1password_setup() {
	info "Configuring 1Password..."
	local confirmed="n"
	while [ "${confirmed}" != "y" ]
	do
		read -p "Is 1Password logged in? (y/n): " confirmed </dev/tty
	done

	local confirmed="n"
	while [ "${confirmed}" != "y" ]
	do
		read -p "Are most options in Settings.Developer enabled? (y/n): " confirmed </dev/tty
	done

	local confirmed="n"
	while [ "${confirmed}" != "y" ]
	do
		read -p "Is 1Password's SSH Agent running? (y/n): " confirmed </dev/tty
	done

	highlight "Configured: 1Password."
}

# Slack
# ==============================================================================
install_slack() {
	# abstraction over ${OS}/${ARCH}/${LINUX_DISTRO}
	return 0
}

install_slack_linux_ubuntu() {
	local package="Slack"
	local deb_package="slack-desktop"
	local version="4.47.69"
	local deb_url="https://downloads.slack-edge.com/desktop-releases/linux/x64/${version}/slack-desktop-${version}-${ARCH}.deb"

	if is_deb_package_installed ${deb_package}
	then
		highlight "Already installed: ${package}."
		return 0
	fi

	info "Installing ${package} (${deb_package})..."
	install_deb_from_url ${deb_package} ${deb_url}

	highlight "Installed: ${package} (.deb: ${deb_url})."
}

# Nix
# ==============================================================================
install_nix() {
	# abstraction over ${OS}/${ARCH}/${LINUX_DISTRO}
	return 0
}

install_nix_linux_ubuntu() {
	local package="Nix"
	local install_script_url="https://install.determinate.systems/nix"
	local bin="/nix/var/nix/profiles/default/bin/nix"

	if [ -f "${bin}" ]
	then
		highlight "Already installed: ${package}."
		return 0
	fi

	info "Installing ${package} (${install_script_url})..."
	curl --proto '=https' --tlsv1.2 -sSf -L ${install_script_url} | sh -s -- install
}

# Dynamically configure home-manager based on current user.
# This requires committing the changes later (one branch per machine).
render_home_manager_for_current_user() {
	local username=$(whoami)

	sed --in-place \
		-e "s|HOME_MANAGER_USERNAME|${username}|g" \
		home-manager/home-manager/home.nix
	sed --in-place \
		-e "s|HOME_MANAGER_USERNAME|${username}|g" \
		home-manager/flake.nix
}

# Others
# ==============================================================================
# Configure mirror for apt
configure_apt_mirror_linux_ubuntu() {
	local backup=$(mktemp)
	local tmp=$(mktemp)
	local src="/etc/apt/sources.list.d/ubuntu.sources"

	local pattern="http://[a-z]\+\.archive\.ubuntu\.com/ubuntu/"
	local ubuntu_mirror="mirror://mirrors.ubuntu.com/mirrors.txt"

	warn "Backing up $src at $backup ..."
	cp $src $backup
	warn "Updating $src to use Ubuntu's mirrors list ..."
	cat $backup | sed -e "s|${pattern}|${ubuntu_mirror}|g" > $tmp
	sudo mv $tmp $src
	rm -f $tmp
}

