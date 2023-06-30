{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.desktop.addons.alacritty;
in
{
  options.plusultra.desktop.addons.alacritty = with types; {
    enable = mkBoolOpt false "Whether to enable Alacritty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];

    plusultra.home.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  };
}
