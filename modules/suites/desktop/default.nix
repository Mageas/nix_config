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
        # gnome = enabled;

        addons = { wallpapers = enabled; };
      };

      apps = {
        firefox = enabled;
        logseq = enabled;
        gparted = enabled;
      };
    };
  };
}
