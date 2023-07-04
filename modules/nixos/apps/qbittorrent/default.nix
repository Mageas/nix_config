{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.qbittorrent;
in
{
  options.plusultra.apps.qbittorrent = with types; {
    enable = mkBoolOpt false "Whether or not to enable qbittorrent.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ qbittorrent ]; };
}
