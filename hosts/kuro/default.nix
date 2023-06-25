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

    # Touchpad
    libinput.enable = true;

    desktopManager.gnome.enable = true;
    windowManager.dwm = {
      enable = true;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = fetchGit {
          url = "git://git.suckless.org/dwm";
          rev = "712d6639ff8e863560328131bbb92b248dc9cde7";
        }; 
        patches = [
          (super.fetchpatch {
            url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/alwayscenter.diff";
            sha256 = "0sr2nzdlm53as576c0vwzdc84flld70v67n04pijqa03jisciysi";
          })
          (super.fetchpatch {
            url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/bar.diff";
            sha256 = "143klyrhmnddwn3i98y7a52i2nlc23486acidzavbfhpafqfy79i";
          })
        ];
      });
    })
  ];


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
