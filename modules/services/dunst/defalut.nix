{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.services.testx;
in
{
  options.plusultra.services.testx = with types; {
    enable = mkBoolOpt false "Whether or not to configure dunst.";
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [ dunst ];

    systemd = {
      user.services.dunst = {
        description = "dunst";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.dunst}/bin/dunst";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };

    plusultra.home.configFile."dunst/dunstrc".source = ./dunstrc;
  };
}
