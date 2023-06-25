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

  # services.xserver = {
  #   enable = true;

  #   displayManager.defaultSession = "none+dwm";
  #   displayManager.lightdm.enable = true;
  # };


  # services.xserver.windowManager.session = pkgs.lib.singleton { 
  #   name = "dwm";
  #   start =
  #     ''
  #       if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
  #         eval $(dbus-launch --exit-with-session --sh-syntax)
  #       fi
  #       systemctl --user import-environment DISPLAY XAUTHORITY

  #       if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  #               dbus-update-activation-environment DISPLAY XAUTHORITY
  #       fi

  #       dwm &
  #       waitPID=$!
  #     '';
  # };


  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "dbus-run-session ${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd dwm";
        user = "mageas";
      };
    };
  };


  services.xserver = {
    enable = true;

    videoDrivers=["amdgpu"];

    # Touchpad
    libinput.enable = true;

    # desktopManager.gnome.enable = true;
    displayManager.lightdm.enable = false;
  };
  


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
  #       # cursorTheme = {
  #       #   package = pkgs.bibata-cursors;
  #       #   name = "Bibata_Amber";
  #       #   size = 32;
  #       # };
  #     };
  #   };
  # };



  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
