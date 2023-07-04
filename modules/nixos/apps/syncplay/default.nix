{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.syncplay;
in
{
  options.plusultra.apps.syncplay = with types; {
    enable = mkBoolOpt false "Whether or not to enable Syncplay.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ syncplay ]; };
}
