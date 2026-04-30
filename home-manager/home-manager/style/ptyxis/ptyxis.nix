{ config, pkgs, lib, ... }:

{
  dconf = {
    settings = {
      "org/gnome/Ptyxis" = {
        default-profile-uuid = "18491460eab52b767cd5366f69ec335fe";
        profile-uuids = ["18491460eab52b767cd5366f69ec335fe"];

        use-system-font = false;
        font-name = "Ubuntu Mono 14";
      };

      "org/gnome/Ptyxis/Profiles/18491460eab52b767cd5366f69ec335fe" = {
        label = "default";
        limit-scrollback = false;
        palette = "solarized";
      };
    };
  };
}
