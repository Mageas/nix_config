{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.services.picom;
in
{
  options.plusultra.services.picom = with types; {
    enable = mkBoolOpt false "Whether or not to configure picom.";
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [ picom ];

    systemd = {
      user.services.picom = {
        description = "picom";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";

            ExecCondition = ''
              ${pkgs.bash}/bin/bash -c '[ "$XDG_SESSION_TYPE" = "x11" ]'
            '';

            ExecStart = "${pkgs.picom}/bin/picom";

            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };

    plusultra.home.configFile."picom/picom.conf".source = ./picom.conf;
  };
}
