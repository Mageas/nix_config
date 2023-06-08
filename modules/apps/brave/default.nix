{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.apps.brave;
in
{
  options.plusultra.apps.brave = with types; {
    enable = mkBoolOpt false "Whether or not to enable Brave.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ brave ]; };
}
