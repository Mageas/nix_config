inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.tools.flatpak;
in
{
  options.plusultra.tools.flatpak = with types; {
    enable = mkBoolOpt false "Whether or not to enable Flatpak.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    environment.sessionVariables = {
      XDG_DATA_DIRS = [ 
        "/var/lib/flatpak/exports/share"
        "/home/${config.plusultra.user.name}/.local/share/flatpak/exports/share"
      ];
    };

  };
}