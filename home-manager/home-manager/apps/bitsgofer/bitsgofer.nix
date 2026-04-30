{ config, pkgs, lib, ... }:

{
  xdg.configFile."git/bitsgofer".text = ''
    [user]
    name = "exklamationmark"
    email = "tonghuukhiem@gmail.com"
  '';

  home.file.".ssh/bitsgofer.config".text = ''
    # Host PATTERN
    # 	User USER
    # 	IdentityFile /path/to/public/key # retrieve private key from SSH agent
    # 	IdentitiesOnly yes
    # 	StrictHostkeyChecking no
  '';
}
