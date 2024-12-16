{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraConfig = builtins.readFile ./init.vim;
  };

  home.activation.createAliasForNeovim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -L ${config.home.homeDirectory}/.local/bin/vim ]; then
      run mkdir -p ${config.home.homeDirectory}/.local/bin
      run ln -s -f ~/.nix-profile/bin/nvim ${config.home.homeDirectory}/.local/bin/vim
    fi
  '';
}
