{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.discord;
  discord = lib.replugged.makeDiscordPlugged {
    inherit pkgs;

    # This is currently broken, but could speed up Discord startup in the future.
    withOpenAsar = true;

    plugins = {
      inherit (inputs) discord-tweaks;
    };

    themes = {
      inherit (inputs) discord-nord-theme;
    };
  };
in
{
  options.plusultra.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    canary.enable = mkBoolOpt false "Whether or not to enable Discord Canary.";
    native.enable = mkBoolOpt false "Whether or not to enable the native version of Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ discord ];
    #   ++ lib.optional cfg.canary.enable pkgs.plusultra.discord
    #   ++ lib.optional cfg.native.enable pkgs.discord;
  };
}