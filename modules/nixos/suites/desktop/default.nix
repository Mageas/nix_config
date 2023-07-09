{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.suites.desktop;
in
{
  options.plusultra.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      desktop = {
        dwm = {
          enable = true;
          isDefaultSession = enabled;
        };

        addons = { wallpapers = enabled; };
      };

      apps = {
        firefox = enabled;
        brave = enabled;
        feh = enabled;
        nemo = enabled;
        file-roller = enabled;
        logseq = enabled;
        gparted = enabled;
      };

      cli-apps {
        joshuto = enabled;
        ncdu = enabled;
        rsync = enabled;
        scrcpy = enabled;
        yt-dlp = enabled;
      };

      tools {
        flatpak = enabled;
      };

      services = {
        avahi = enabled;
        samba = enabled;
        picom = enabled;
        gammastep = enabled;
        dunst = enabled;
      };

      system = {
        lightdm = enabled;
      };
    };
  };
}
