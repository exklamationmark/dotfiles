{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraConfig = builtins.readFile ./init.vim;
  };

  # TODO: does not seem to run???
  # home.activation.installNeovimPlugins = lib.mkAfter ''
  #   ${pkgs.neovim}/bin/nvim +':PlugInstall --sync' +qall
  # '';
}
