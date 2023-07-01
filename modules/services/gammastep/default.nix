{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.services.gammastep;
in
{
  options.plusultra.services.gammastep = with types; {
    enable = mkBoolOpt false "Whether or not to configure gammastep.";
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [ gammastep ];

    systemd = {
      user.services.gammastep = {
        description = "gammastep";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
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
