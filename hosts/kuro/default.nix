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


  # nixpkgs.ovelays = [
  #   (self: super: {
  #     dwm = super.dwm.overrideAttrs (oldAttrs: rec {
  #       # src = builtins.fetchGit {
  #       #   url = https://git.suckless.org/dwm;
  #       #   rev = "e32929bfb3c5a87ab5cd810d3e6074c822adc720";
  #       # };
  #       patches = [
  #         (super.fetchpatch {
  #           url = "https://github.com/Mageas/dwm/blob/main/patches/alwayscenter.diff";
  #           sha256 = "51fbc8749403282ce325c01eb3c169943a8258fb7c03664ed16a944adbb7226b";
  #         })
  #       ];
  #     });
  #   })
  # ];
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = builtins.fetchGit https://git.suckless.org/dwm;
        patches = [
          (super.fetchpatch {
            url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/alwayscenter.diff";
            sha256 = "0sr2nzdlm53as576c0vwzdc84flld70v67n04pijqa03jisciysi";
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
