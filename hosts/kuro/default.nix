{ pkgs, config, lib, ... }:
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

    displayManager.defaultSession = "none+dwm";
    displayManager.lightdm.enable = true;
  };


  # services.xserver.windowManager.session = pkgs.lib.singleton { 
  #   name = "dwm";
  #   start =
  #     ''
  #       dwm &
  #       waitPID=$!
  #     '';
  # };
  


  # services.xserver = {
  #   enable = true;

  #   # Touchpad
  #   libinput.enable = true;

  #   # desktopManager.gnome.enable = true;
  #   displayManager.defaultSession = "none+dwm";
  #   displayManager.lightdm = {
  #     enable = true;
  #     greeters.gtk = {
  #       theme.name = "Sweet-mars";
  #       cursorTheme = {
  #         package = pkgs.bibata-cursors;
  #         name = "Bibata_Amber";
  #         size = 32;
  #       };
  #     };
  #   };
  # };



  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
