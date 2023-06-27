{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      dwm.enable = true;
    };
  };


  services.xserver = {
    enable = true;

    # Touchpad
    libinput.enable = true;

    desktopManager.gnome.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Materia-dark";
          package = pkgs.materia-theme;
        };
        indicators = [ "~session" "~power" ];
        extraConfig = ''
          hide-user-image = true
        '';
      };
    };
    
    
    displayManager.defaultSession = "none+dwm";
  };


  # wayland.windowManager.hyprland.enable = true;


  # nixpkgs.wayland.windowManager.hyprland = {
  #   enable = true;
  #   xwayland = {
  #     enable = true;
  #     hidpi = false;
  #   };
  #   nvidiaPatches = false;
  # };

  # programs.hyprland = {
  #   enable = true;

  #   # default options, you don't need to set them
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  #   xwayland = {
  #     enable = true;
  #     hidpi = false;
  #   };

  #   nvidiaPatches = false;
  # };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
