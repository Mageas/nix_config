{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.firefox;
in
{
  options.plusultra.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.firefox.enable = true;
  };
}
