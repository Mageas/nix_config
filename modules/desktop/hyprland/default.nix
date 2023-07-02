{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.desktop.hyprland;
in
{
  options.plusultra.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland.";
    isDefaultSession = mkBoolOpt true "Whether or not to make Hyprland the default session.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    plusultra.desktop.addons = {
      alacritty = enabled;
      autostart = enabled;
      gtk = enabled;
      polkit = enabled;
      rofi = enabled;
      # sxhkd = enabled;
      wallpapers = enabled;
      xdg-portal = enabled;
    };

    programs.hyprland = {
      enable = true;

      nvidiaPatches = false;
        xwayland = {
        enable = true;
        hidpi = true;
      };
    };

    # plusultra.home.file.".local/bin/statusbar".source = ./statusbar;


  };
}
