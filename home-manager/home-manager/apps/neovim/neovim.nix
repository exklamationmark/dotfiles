{ config, pkgs, lib, ... }:

let
  configFragments = [
    ./config/plugins.vim
    ./config/neosolarized.vim
    ./config/spellcheck.vim
    ./config/nvim_lspconfig.vim
    ./config/golang.vim
    ./config/all.vim
  ];
  extraConfig = builtins.concatStringsSep "\n" (map builtins.readFile configFragments);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraConfig = extraConfig;
  };

  # Post-install:
  # - Create alias for vim -> nvim
  # - Run :PlugInstall, :GoInstallBinaries
  # - Symlink spell definitions to track them, then run :RecompileSpell
  home.activation.neovimPostInstall = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -L ${config.home.homeDirectory}/.local/bin/vim ]; then
      run mkdir -p ${config.home.homeDirectory}/.local/bin
      run ln -s -f ~/.nix-profile/bin/nvim ${config.home.homeDirectory}/.local/bin/vim
    fi

    if [ ! -L ${config.home.homeDirectory}/.config/nvim/spell ]; then
      run ln -s -f ~/workspace/src/github.com/exklamationmark/dotfiles/home-manager/home-manager/apps/neovim/spell ${config.home.homeDirectory}/.config/nvim/spell
    fi
  '';
}
