{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.gnumake
    pkgs.curl
    pkgs.xclip
    pkgs.pandoc
    pkgs.tree
    pkgs.jq
    pkgs.d2
    pkgs.dig
    pkgs.netcat-gnu
    pkgs.socat
    pkgs.tcpdump
    pkgs.vault
    pkgs.terraform
    pkgs.kubernetes-helm
    pkgs.kustomize
    pkgs.dyff
    pkgs.virtualbox
    (pkgs.google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ]) # REF: https://github.com/NixOS/nixpkgs/issues/182856#issuecomment-2319115082
    pkgs.bat
    pkgs.glow
  ];
}
