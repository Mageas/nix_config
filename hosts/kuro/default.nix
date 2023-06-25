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
    vt = 1;
    settings = {
      default_session = {
        command = let
          tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
          sessions = "--sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions";
        in
          builtins.concatStringsSep " " [
            tuigreet
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
    diaplayManager.startx.enable = true;
    displayManager.lightdm.enable = false;
  };



  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
