{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.gnumake
    pkgs.curl
    pkgs.xclip
    pkgs.pandoc
    pkgs.tree
    pkgs.jq
    pkgs.yq
  ];
}
