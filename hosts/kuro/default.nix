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


  services.xserver.windowManager.session = singleton { 
    name = "dwm";
    start =
      ''
        dwm &
        waitPID=$!
      '';
  };
  


  services.xserver = {
    enable = true;

    # Touchpad
    libinput.enable = true;

    # desktopManager.gnome.enable = true;
    displayManager.defaultSession = "none+dwm";
    displayManager.lightdm = {
      enable = true;
      greeters.pantheon.enable = true;
    };
  };



  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
