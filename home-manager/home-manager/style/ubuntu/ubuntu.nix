{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.dconf-editor
    pkgs.dconf2nix
  ];

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

      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "org.gnome.Terminal.desktop"
          "firefox.desktop"
          "google-chrome.desktop"
          "1password.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

    };
  };
}
