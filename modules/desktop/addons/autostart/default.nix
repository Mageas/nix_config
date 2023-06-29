{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.desktop.addons.autostart;
in
{
  options.plusultra.desktop.addons.autostart = with types; {
    enable =
      mkBoolOpt false "Whether to enable Autostart script.";
  };

  config = mkIf cfg.enable {  
    der = pkgs.stdenv.mkDerivation {
      name = "lightdm-autostart";
      src = ./lightdm-autostart;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/share
        cp $src $out/share/
      '';
    };
  };
}