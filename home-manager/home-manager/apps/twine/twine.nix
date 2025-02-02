{ config, pkgs, lib, ... }:

let
  install_dir="${config.home.homeDirectory}/.local/share/twine";
in
{
  home.file.".local/share/applications/twine.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=Twine
      GenericName=Twine
      Exec=${install_dir}/twine
      Icon=${install_dir}/twine.svg
      Terminal=false
      Categories=Development;Game;
      StartupNotify=true
    '';
  };
}
