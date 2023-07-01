{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.rsync;
in
{
  options.plusultra.cli-apps.rsync = with types; {
    enable = mkBoolOpt false "Whether or not to enable rsync.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rsync ];
  };
}
