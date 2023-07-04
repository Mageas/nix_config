{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.scrcpy;
in
{
  options.plusultra.cli-apps.scrcpy = with types; {
    enable = mkBoolOpt false "Whether or not to enable scrcpy.";
  };

  config = 
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ scrcpy ]; };
}
