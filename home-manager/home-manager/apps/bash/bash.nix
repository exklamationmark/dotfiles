{ config, pkgs, lib, ... }:

let
  # Parts to add to .bashrc. Final .bashrc looks like this:
  #
  #   home.file.".bashrc".source = writeBashScript "bashrc" ''
  #     ${cfg.bashrcExtra}
  #
  #     [code added by home-manager.programs.bash]
  #
  #     ${cfg.initExtra}
  #   '';
  #
  # REF: https://github.com/nix-community/home-manager/blob/release-24.05/modules/programs/bash.nix#L220-L233
  bashrcExtraFragments = [
    ./bashrc.d/ubuntu.bash
    ./bashrc.d/extra.bash
    ./bashrc.d/aliases.bash
    ./bashrc.d/d2.bash
    ./bashrc.d/ps1.bash
    ./bashrc.d/kubernetes.bash
    ../go/bashrc.d/go.bash
    ./bashrc.d/rust.bash
    ../work/bashrc.d/tailscale.bash
  ];
  bashrcExtra = builtins.concatStringsSep "\n" (map builtins.readFile bashrcExtraFragments);

  initExtraFragments = [
    ./bashrc.d/history.bash
  ];
  initExtra = builtins.concatStringsSep "\n" (map builtins.readFile initExtraFragments);
in
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = bashrcExtra;
    initExtra = initExtra;

    shellAliases = {
      # TODO: combine shell alias from multiple apps here
      vim = "nvim"; # TODO: split into: apps/neovim
    };
  };
}
