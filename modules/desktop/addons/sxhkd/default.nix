{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.desktop.addons.sxhkd;
in
{
  options.plusultra.desktop.addons.sxhkd = with types; {
    enable =
      mkBoolOpt false "Whether to enable Sxhkd in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sxhkd ];

    plusultra.home.configFile."sxhkd/sxhkdrc".source = ./sxhkdrc;
  };
}