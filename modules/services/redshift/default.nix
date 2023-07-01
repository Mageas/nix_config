{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.services.redshift;
in
{
  options.plusultra.services.redshift = with types; {
    enable = mkBoolOpt false "Whether or not to configure redshift.";
  };

  config = mkIf cfg.enable { 
    services.redshift = {
      enable = true;
      extraOptions = [
        "-c"
        "/home/${config.plusultra.user.name}/.config/redshift/redshift.conf"
      ];
    };

    plusultra.home.configFile."redshift/redshift.conf".source = ./redshift.conf;
  };
}
