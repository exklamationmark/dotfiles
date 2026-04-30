{ config, pkgs, lib, ... }:

{
  programs.go = {
    enable = true;

    env = {
      GOPATH = "workspace";
    };
  };

  home.packages = [
    pkgs.golangci-lint
  ];
}
