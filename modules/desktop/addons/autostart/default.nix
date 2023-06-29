{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let 
  cfg = config.plusultra.desktop.addons.autostart;
  lightdm-autostart = pkgs.stdenv.mkDerivation {
    name = "lightdm-autostart";
    src = ./lightdm-autostart;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share
      cp $src $out/share/
    '';
  };
in
{
  options.plusultra.desktop.addons.autostart = with types; {
    enable =
      mkBoolOpt false "Whether to enable Autostart script.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lightdm-autostart ];
  };
}