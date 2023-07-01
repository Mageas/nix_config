{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.services.picom;
in
{
  options.plusultra.services.picom = with types; {
    enable = mkBoolOpt false "Whether or not to configure picom.";
  };

  config = mkIf cfg.enable { 
    services.picom = {
      enable = true;
      opacityRules = [
        "98:class_g = 'Alacritty'"
      ];
      fadeSteps = [
        0.05
        0.05
      ];
    };
  };
}
