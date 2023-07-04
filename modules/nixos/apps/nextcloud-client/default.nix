{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.nextcloud-client;
in
{
  options.plusultra.apps.nextcloud-client = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nextcloud client.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ nextcloud-client ]; };
}
