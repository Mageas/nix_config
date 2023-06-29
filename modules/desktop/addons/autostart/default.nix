{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let 
  cfg = config.plusultra.desktop.addons.autostart;
  lightdmAutostart = pkgs.stdenvNoCC.mkDerivation {
    name = "lightdm-autostart";
    src = ./lightdm-autostart;
    phases = [ "build" "install" ];
    buildInputs = [];
    buildPhase = ''
      echo "Building lightdm-autostart"
    '';
    installPhase = ''
      mkdir -p $out/share
      cp -r $src $out/share/lightdm-autostart
    '';
  };
in
{
  options.plusultra.desktop.addons.autostart = with types; {
    enable =
      mkBoolOpt false "Whether to enable Autostart script.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lightdmAutostart ];
  };
}