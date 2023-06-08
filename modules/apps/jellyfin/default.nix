{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.apps.jellyfin;
in
{
  options.plusultra.apps.jellyfin = with types; {
    enable = mkBoolOpt false "Whether or not to enable Jellyfin.";
  };

  config =
    mkIf cfg.enable { 
      plusultra.user.extraGroups = [ "jellyfin" ];
      
      plusultra.services = {
        jellyfin = enabled;
      };
    };
}
