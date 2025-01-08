{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    VAULT_ADDR = "WORK_VAULT_ADDRESS";
    GITHUB_TOKEN = "WORK_PERSONAL_GITHUB_TOKEN";
  };
}
