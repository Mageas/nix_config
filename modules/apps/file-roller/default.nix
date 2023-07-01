{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.file-roller;
in
{
  options.plusultra.apps.file-roller = with types; {
    enable = mkBoolOpt false "Whether or not to enable file-roller.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnome.file-roller ];
  };
}
