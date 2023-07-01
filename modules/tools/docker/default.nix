inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.tools.docker;
in
{
  options.plusultra.tools.docker = with types; {
    enable = mkBoolOpt false "Whether or not to enable Docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    plusultra.user.extraGroups = [ "docker" ];
  };
}