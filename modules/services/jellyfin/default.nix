{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.services.jellyfin;
in
{
  options.plusultra.services.jellyfin = with types; {
    enable = mkBoolOpt false "Whether or not to configure jellyfin.";
  };

  config = mkIf cfg.enable { 
    services.jellyfin.enable = true;
    
    plusultra.user.extraGroups = [ "jellyfin" ];
  };
}
