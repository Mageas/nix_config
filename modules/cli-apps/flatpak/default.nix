inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.flatpak;
  flatpakFlathub = pkgs.writeShellScriptBin "flatpak-flathub" ''
    #!/usr/bin/env bash
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  '';
in
{
  options.plusultra.cli-apps.flatpak = with types; {
    enable = mkBoolOpt false "Whether or not to enable Flatpak.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    environment.systemPackages = [ flatpakFlathub ];
  };
}