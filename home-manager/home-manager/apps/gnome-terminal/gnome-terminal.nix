{ config, pkgs, lib, ... }:

{
  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    themeVariant = "dark";

    profile.cad58b7c-0c29-4777-a306-fbadce7303bb = {
      default = true;
      visibleName = "default";

      showScrollbar = false;

      font = "Ubuntu Mono 13";


      colors = {
        backgroundColor = "#002B36";
        foregroundColor = "#839496";

        palette = [
          "#073642"
          "#DC322F"
          "#859900"
          "#B58900"
          "#268BD2"
          "#D33682"
          "#2AA198"
          "#EEE8D5"
          "#002B36"
          "#CB4B16"
          "#586E75"
          "#657B83"
          "#839432"
          "#6C71C4"
          "#93A1A1"
          "#FDF6E3"
        ];
      };

      audibleBell = false;
    };
  };
}
