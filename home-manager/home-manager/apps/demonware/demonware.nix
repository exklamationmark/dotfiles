{ config, pkgs, lib, ... }:

{
  xdg.configFile."git/demonware".text = ''
    [user]
    name = "mtong"
    email = "mtong@demonware.net"

    # Used with GOPRIVATE
    # [url "git@WORK_GITHUB_ENTERPRISE_DOMAIN:"]
    # 	insteadOf = "https://WORK_GITHUB_ENTERPRISE_DOMAIN"
  '';

  home.file.".ssh/demonware.config".text = ''
    # Host PATTERN
    # 	User USER
    # 	IdentityFile /path/to/public/key # retrieve private key from SSH agent
    # 	IdentitiesOnly yes
    # 	StrictHostkeyChecking no
  '';

  home.sessionVariables = {
    VAULT_ADDR = "WORK_VAULT_ADDRESS";
    GITHUB_TOKEN = "WORK_PERSONAL_GITHUB_TOKEN";
    GOPRIVATE = "WORK_GOPRIVATE";
  };

  home.packages = [
  ];
}
