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

    systemd = {
      user.services.gammastep = {
        description = "gammastep";
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.gammastep}/bin/gammastep";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };

    plusultra.home.configFile."gammastep/config.ini".source = ./config.ini;
  };
}
