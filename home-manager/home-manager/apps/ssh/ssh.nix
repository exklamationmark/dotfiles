{ config, pkgs, lib, ... }:

{
  home.file.".ssh/config" = {
    text = builtins.readFile ./config;
  };
}
