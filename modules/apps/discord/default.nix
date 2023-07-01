{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.discord;
  flatpakDiscord = pkgs.writeShellScriptBin "flatpak-discord" ''
    #!/usr/bin/env bash
    flatpak install com.discordapp.Discord
  '';
in
{
  options.plusultra.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ flatpakDiscord ];
  };
}
