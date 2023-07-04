{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.apps.nemo;
in
{
  options.plusultra.apps.nemo = with types; {
    enable = mkBoolOpt false "Whether or not to enable nemo.";
  };

  config =
    mkIf cfg.enable {
      services.gvfs.enable = true;
      
      environment.systemPackages = with pkgs; [
        cinnamon.nemo
        cinnamon.nemo-fileroller
        cifs-utils
      ];
    };
}
