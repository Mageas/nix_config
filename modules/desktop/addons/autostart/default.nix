{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let 
  cfg = config.plusultra.desktop.addons.autostart;
  # lightdmAutostart = pkgs.stdenvNoCC.mkDerivation {
  #   name = "lightdm-autostart";
  #   src = ./lightdm-autostart;
  #   phases = [ "build" "install" ];
  #   buildInputs = [];
  #   buildPhase = ''
  #     echo "Building lightdm-autostart"
  #   '';
  #   installPhase = ''
  #     mkdir -p $out/share/lightdm-autostart
  #     cp -r $src $out/share/lightdm-autostart/
  #   '';
  # };

  # lightdmAutostart = pkgs.runCommandNoCC "lightdm-autostart"
  #   { } ''
  #     local target="$out/share"
  #     mkdir -p "$target"

  #     cp ${./lightdm-autostart} "$target/lightdm-autostart"
  #   '';

  # lightdmAutostart = pkgs.stdenvNoCC.mkDerivation {
  #   name = "lightdm-autostart";
  #   src = ./.;
  #   phases = [ "unpackPhase" "installPhase" ];
  #   installPhase = ''
  #     local target="/run/current-system/sw/share"

  #     mkdir -p $target
  #     cp $src/lightdm-autostart $target
  #   '';
  # };
in
{
  options.plusultra.desktop.addons.autostart = with types; {
    enable =
      mkBoolOpt false "Whether to enable Autostart script.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ lightdmAutostart ];
    # environment.etc."lightdm/lightdm-autostart".source = ./lightdm-autostart;
    plusultra.home.file.".xprofile".source = ./xprofile;
  };
}