{ config, pkgs, lib, ... }:

{
  home.file.".ssh/config".text = ''
    Host *
    	IdentityAgent ~/.1password/agent.sock

    Include exklamationmark.config
    Include demonware.config
    Include bitsgofer.config
  '';
}
