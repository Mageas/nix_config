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

  services.greetd = let
    dwmConfig = pkgs.writeText "greetd-dwm-config" ''
      dwm"
    '';
  in {
    enable = true;
    settings = {
      default_session = {
        command = "exec ${pkgs.greetd.tuigreet}/bin/tuigreet --cmd dwm";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    dwm
    bash
    startxfce4
  '';


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
