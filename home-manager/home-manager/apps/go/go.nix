{ config, pkgs, lib, ... }:

{
  programs.go = {
    enable = true;

    goPath = "workspace";

    goPrivate = [
      # "*.work.domain"
    ];
  };

  home.packages = [
    pkgs.golangci-lint
  ];
}
