{ pkgs, config, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  # modules = {
  #   desktop = {
  #     bspwm.enable = true;
  #     apps = {
  #       rofi.enable = true;
  #     };
  #     browsers = {
  #       default = "brave";
  #       brave.enable = true;
  #       firefox.enable = true;
  #       qutebrowser.enable = true;
  #     };
  #     gaming = {
  #       steam.enable = true;
  #       # emulators.enable = true;
  #       # emulators.psx.enable = true;
  #     };
  #   };
  #   shell = {
  #     adl.enable = true;
  #     vaultwarden.enable = true;
  #     direnv.enable = true;
  #     git.enable    = true;
  #     gnupg.enable  = true;
  #     tmux.enable   = true;
  #     zsh.enable    = true;
  #   };
  # };


  services.greetd = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "fr";

    # Touchpad
    libinput.enable = true;

    windowManager.awesome.enable = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
