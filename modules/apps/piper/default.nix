{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.piper;
in
{
  options.plusultra.apps.piper = with types; {
    enable = mkBoolOpt false "Whether or not to enable Piper.";
  };

  config = mkIf cfg.enable {
      services.ratbagd.enable = true;
      environment.systemPackages = with pkgs; [ piper ];
    };
}