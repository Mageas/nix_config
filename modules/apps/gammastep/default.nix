{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.gammastep;
in
{
  options.plusultra.apps.gammastep = with types; {
    enable = mkBoolOpt false "Whether or not to configure gammastep.";
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [ gammastep ];

    plusultra.home.configFile."redshift/redshift.conf".source = ./redshift.conf;
  };
}
