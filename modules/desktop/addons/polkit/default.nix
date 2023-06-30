{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.desktop.addons.polkit;
in
{
  options.plusultra.desktop.addons.polkit = with types; {
    enable = mkBoolOpt false "Whether to enable Polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };
  };
}
