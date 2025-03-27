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
    pkgs.bat
    pkgs.glow
    pkgs.nettools

    # Google Cloud CLI
    # REF: https://github.com/NixOS/nixpkgs/issues/182856#issuecomment-2319115082
    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])

    # Azure CLI
    (pkgs.azure-cli.withExtensions [
      pkgs.azure-cli-extensions.amg
      pkgs.azure-cli-extensions.next
      pkgs.azure-cli.extensions.aks-preview
      pkgs.azure-cli-extensions.k8s-runtime
      pkgs.azure-cli-extensions.k8s-extension
    ])
    pkgs.kubelogin
  ];
}
