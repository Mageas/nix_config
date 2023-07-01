inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.feh;
in
{
  options.plusultra.apps.feh = with types; {
    enable = mkBoolOpt false "Whether or not to enable feh.";
  };

  config = 
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ feh ]; };
}
