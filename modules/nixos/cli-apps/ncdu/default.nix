{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.ncdu;
in
{
  options.plusultra.cli-apps.ncdu = with types; {
    enable = mkBoolOpt false "Whether or not to enable ncdu.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ ncdu ]; };
}
