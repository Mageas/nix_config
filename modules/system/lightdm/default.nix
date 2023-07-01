{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.system.lightdm;
in
{
  options.plusultra.system.lightdm = with types; {
    enable = mkBoolOpt false "Whether or not to enable lightdm.";
  };

  config = mkIf cfg.enable {
    # services.accounts-daemon.enable = true;
    services.xserver = {
      enable = true;
      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          theme = {
            name = "Materia-dark";
            package = pkgs.materia-theme;
          };
          indicators = [ "~session" "~power" ];
          extraConfig = ''
            hide-user-image = true
          '';
        };
      };
      libinput.enable = true;
    };
  };
}
