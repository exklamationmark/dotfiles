{ config, pkgs, lib, ... }:

let
  install_dir="${config.home.homeDirectory}/.local/share/godot";
in
{
  home.file.".local/share/applications/godot.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=Godot 4 (GDScript)
      GenericName=Godot 4 (GDScript)
      Exec=${install_dir}/godot
      Icon=${install_dir}/godot.svg
      Terminal=false
      Categories=Development;Game;
      StartupNotify=true
    '';
  };

  home.file.".local/share/applications/godot_dotnet.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=Godot 4 (.NET)
      GenericName=Godot 4 (.NET)
      Exec=${install_dir}/godot_dotnet/godot_dotnet
      Icon=${install_dir}/godot_dotnet.svg
      Terminal=false
      Categories=Development;Game;
      StartupNotify=true
    '';
  };

}
