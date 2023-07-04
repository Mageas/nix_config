{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.cryptomator;
in
{
  options.plusultra.apps.cryptomator = with types; {
    enable = mkBoolOpt false "Whether or not to enable Cryptomator.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ cryptomator ]; };
}
