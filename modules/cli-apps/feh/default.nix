inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.feh;
in
{
  options.plusultra.cli-apps.feh = with types; {
    enable = mkBoolOpt false "Whether or not to enable feh.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.feh.enable = true;
  };
}
