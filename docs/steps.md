# Virtual box setup

- On host: sudo apt-get install virtualbox-guest-additions-iso
- Mount image to guest VM
- On guest: sudo apt-get install gcc make perl

# nix installer

- Install curl
- Use the installer from Determinate System

      sudo apt-get install curl -y
      curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
        sh -s -- install

- Open a new shell
- Run

      sudo apt-get install git -y
      mkdir -p ${HOME}/workspace/src/github.com/exklamationmark
      cd ${HOME}/workspace/src/github.com/exklamationmark
      git clone https://github.com/exklamationmark/dotfiles.git
      cd dotfiles
      # DEBUG: git checkout nix
      ln -sf ${PWD}/home-manager ${HOME}/.config/home-manager
      cd ~/.config/home-manager
      rm ~/.bashrc ~/.profile
      nix run home-manager switch -- -b backup
      gnome-session-switch

- NOTE: Nix need to configure locale
