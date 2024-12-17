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
    pkgs.d2
    pkgs.dig
    pkgs.netcat-gnu
    pkgs.socat
    pkgs.tcpdump
    pkgs.vault
    pkgs.terraform
  ];
}
