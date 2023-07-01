{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let 
    cfg = config.plusultra.system.lightdm;
    defaultFace = pkgs.runCommandNoCC "propagated-icon"
    ''
      cp ../../user/profile.png "/var/lib/AccountsService/icons/${config.plusultra.user.name}.png"
    '';
in
{
  options.plusultra.system.lightdm = with types; {
    enable = mkBoolOpt false "Whether or not to enable lightdm.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      defaultFace
    ];
    services.accounts-daemon.enable = true;
    services.xserver = {
      enable = true;
      displayManager.lightdm = {
        enable = true;
        background = ./background.png;
        greeters.gtk = {
          enable = true;
          theme = {
            name = "Arc-Dark";
            package = pkgs.arc-theme;
            # name = "Materia-dark";
            # package = pkgs.materia-theme;
          };
          indicators = [ "~session" "~power" ];
        #   extraConfig = ''
        #     hide-user-image = true
        #   '';
        };
      };
      libinput.enable = true;
    };
  };
}
