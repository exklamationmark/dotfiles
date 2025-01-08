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

        text-scaling-factor = 1; # Larger text

        clock-format = "24h";
        clock-show-date = true;
        clock-show-seconds = true;
        clock-show-weekday = true;

        enable-animations = false;

        enable-hot-corners = true;
      };

      # Lock screen
      "org/gnome/desktop/session" = with lib.hm.gvariant; {
        idle-delay = mkUint32 900; # Screen goes blank after 15m
      };
      "org/gnome/desktop/screensaver" = with lib.hm.gvariant; {
        lock-enabled = true;
        lock-delay = mkUint32 3600; # Lock screen 1h after screen went blank
      };

      # Dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 32;
        dock-position = "RIGHT";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "org.gnome.Terminal.desktop"
          "firefox.desktop"
          "google-chrome.desktop"
          "1password.desktop"
          "slack_slack.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

      # Keyboard shortcuts
      "org/gnome/settings-daemon/plugins/media-keys" = {
        screensaver = [ "<Shift><Control>slash" ];
      };
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Shift><Control>8" ];
      };
    };
  };
}
