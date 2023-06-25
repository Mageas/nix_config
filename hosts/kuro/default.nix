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


  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = let
          greet = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";
          sessions = "--sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions";
        in
          builtins.concatStringsSep " " [
            greet
            "--time"
            sessions
          ];
        user = "mageas";
      };
      switch = false;
    };
  };


  services.xserver = {
    enable = true;

    # Touchpad
    libinput.enable = true;

    # desktopManager.gnome.enable = true;
    displayManager.lightdm.enable = false;
  };



  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
