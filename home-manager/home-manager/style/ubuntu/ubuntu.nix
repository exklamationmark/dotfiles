{ config, pkgs, lib, ... }:

{
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "blue";
        gtk-theme = "Yaru-dark";
        icon-theme = "Yaru";

        clock-format = "24h";
        clock-show-date = true;
        clock-show-seconds = false;
        clock-show-weekday = false;

        enable-animations = false;

        enable-hot-corners = true;
      };
    };
  };
}
