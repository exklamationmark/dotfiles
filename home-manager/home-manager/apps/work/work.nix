{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    VAULT_ADDR = "https://vault.bitsgofer.net";
    GITHUB_TOKEN = "foobar";
    GOPRIVATE = "git.bitsgofer.net";
  };

  home.packages = [
    pkgs.az-pim-cli
  ];

}
