{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.yt-dlp;
in
{
  options.plusultra.cli-apps.yt-dlp = with types; {
    enable = mkBoolOpt false "Whether or not to enable yt-dlp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ yt-dlp ];
  };
}
