inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.cli-apps.flatpak;
in
{
  options.plusultra.cli-apps.flatpak = with types; {
    enable = mkBoolOpt false "Whether or not to enable Flatpak.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}