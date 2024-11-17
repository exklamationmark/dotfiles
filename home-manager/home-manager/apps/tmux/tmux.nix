{ config, pkgs, lib, ... }:

let
  tmuxConfExtraFragments = [
    ./tmux.conf
  ];
  extraConfig = builtins.concatStringsSep "\n" (map builtins.readFile tmuxConfExtraFragments);
in
{
  programs.tmux = {
    enable = true;

	baseIndex = 1;
	clock24 = true;
	historyLimit = 999999;
	keyMode = "vi";
	mouse = true;

	prefix = "C-a";
	escapeTime = 200;

	extraConfig = extraConfig;
  };
}
