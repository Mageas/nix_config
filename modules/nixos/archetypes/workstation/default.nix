{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let 
  cfg = config.plusultra.archetypes.workstation;
in
{
  options.plusultra.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      suites = {
        art = enabled;
        common = enabled;
        # desktop = enabled;
        development = enabled;
        media = enabled;
        music = enabled;
        social = enabled;
        video = enabled;
      };

      tools = {
        appimage-run = enabled;
        flatpak = enabled;
      };

      cli-apps = {
        joshuto = enabled;
      };
    };
  };
}
